import doobie._
import doobie.implicits._
import cats.effect.IO.asyncForIO
import cats.effect._
import cats.effect.unsafe.implicits.global
import doobie.util.log.LogHandler.jdkLogHandler
import doobie.util.transactor.Transactor.Aux
import mohaymen.onlineprocessing.{Gender, Ids, Person, PostalAddress, PostalCode, Service}

object Application2 extends App {



  override def main(args: Array[String]): Unit = {
    super.main(args)
    val transactor: Aux[IO, Unit] = {
      Transactor.fromDriverManager[IO](
        "org.postgresql.Driver",
        "jdbc:postgresql://localhost:5433/local_db",
        "dbuser",
        "dbpassword",
      )
    }
    val person: Person = Person("mohammad","ezadeh","ali","777","1392/02/02",Gender(true),"342342334")
    val address: PostalAddress = PostalAddress("poonak",PostalCode("234234243"),"232434")
    val service: Service = Service("09127040915","234234",2323,23,234)

    val sql = for {
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
      val r = sql.transact(transactor).unsafeRunSync()
    println(r)
    }
}
