package mohaymen.onlineprocessing
import Configs.{AppConfig, JdbcConfig}
import FlinkHelpers.AsyncDatabaseQuery
import doobie.implicits.toSqlInterpolator
import doobie.util.log.LogHandler.jdkLogHandler
import mohaymen.onlineprocessing.validator.{FieldError, FormErrors}
import org.apache.flink.streaming.api.scala.{DataStream, createTypeInformation}
import shapeless.HList._
import shapeless.Nat.{_0, _1, _2}
import shapeless._

object Subscription {
  def map(
           input: DataStream[RegisteredMobile :: String :: HNil],
           configs: AppConfig
         ): DataStream[Either[(String, FormErrors), Ids :: RegisteredMobile :: String :: HNil]]
  = {
    val insertPhone: DataStream[Option[Ids] :: RegisteredMobile :: String :: HNil] = AsyncDatabaseQuery.augmentWithSingle[RegisteredMobile :: String :: HNil, Ids](
      input, in => {
        val person: Person = in.at[_0].person
        val address: PostalAddress = in.at[_0].address
        val service: Service = in.at[_0].service
        for {
          customerId <- sql"""insert into "Customer" (
                  name,
                  family,
                  father_name,
                  certification_no,
                  birth_date,
                  gender,
                  identification_no
            ) values (
            ${person.name},
            ${person.family},
            ${person.fatherName},
            ${person.certificationNo},
            ${person.birthDate},
            ${person.gender.value},
            ${person.identificationNo}
            )"""
            .updateWithLogHandler(jdkLogHandler)
            .withUniqueGeneratedKeys[Int]("id")
          addressId <- sql"""insert into "Address" (
             address,
             postal_code,
             tel,
             customer_id
         ) values (
            ${address.address},
            ${address.postalCode},
            ${address.tel},
            ${customerId}
          )"""
            .updateWithLogHandler(jdkLogHandler)
            .withUniqueGeneratedKeys[Int]("id")
          serviceId <-
            sql"""insert
                 into "Service"
                   (
                   mobile_number,
                   imsi,
                   sms,
                   data3g,
                   data4g,
                   customer_id
                   )
                 values (
            ${service.mobileNumber},
            ${service.imsi},
            ${service.sms},
            ${service.data3g},
            ${service.data4g},
            ${customerId}
          )
                 """
            .updateWithLogHandler(jdkLogHandler)
            .withUniqueGeneratedKeys[Int]("id")
        } yield Ids(customerId, addressId, serviceId)
      }
      , configs.localJdbcConfig)
    insertPhone.map(x => {
      x.head match {
        case Some(h) => Right(h :: x.tail)
        case None =>
          Left(
            (
              x.at(_2),
              FormErrors(Seq(FieldError("/", Seq("subscription phase failed."))))
            )
          )
      }
    }
    )
  }
}
