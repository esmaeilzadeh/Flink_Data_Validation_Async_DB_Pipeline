package mohaymen.onlineprocessing
import Configs.{AppConfig, JdbcConfig}
import FlinkHelpers.AsyncDatabaseQuery
import cats.free.Free
import doobie.free.connection
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
    AsyncDatabaseQuery.augmentWithSingle[RegisteredMobile :: String :: HNil, Ids](
      input, x => insertRegisteredMobile(x.at[_0])
      , configs.localJdbcConfig
    ).map(
      x => {
      x.head match {
        case Right(h) => Right(h :: x.tail)
        case Left(l) =>
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

  def insertRegisteredMobile(in: RegisteredMobile): Free[connection.ConnectionOp, Ids] = {
    for {
      customerId <- insertPerson(in.person)
      addressId <- insertAddress(in.address, customerId)
      serviceId <- insertService(in.service, customerId)
    } yield Ids(customerId, addressId, serviceId)
  }

  private def insertService(service: Service, customerId: Int) = {
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
  }

  private def insertAddress(address: PostalAddress, customerId: Int) = {
    sql"""insert into "Address" (
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
  }

  private def insertPerson(person: Person): doobie.ConnectionIO[Int] = {
     sql"""insert into "Customer" (
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
      .updateWithLogHandler(jdkLogHandler).withUniqueGeneratedKeys[Int]("id")
  }
}
