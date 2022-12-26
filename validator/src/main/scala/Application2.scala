import doobie._
import doobie.implicits._
import cats.effect.IO.asyncForIO
import cats.effect._
import cats.effect.unsafe.implicits.global
import cats.free.Free
import doobie.free.connection
import doobie.hikari.HikariTransactor
import doobie.util.ExecutionContexts
import doobie.util.log.LogHandler.jdkLogHandler
import doobie.util.transactor.Transactor.Aux
import mohaymen.onlineprocessing.Subscription.insertRegisteredMobile
import mohaymen.onlineprocessing.{Gender, Ids, Person, PostalAddress, PostalCode, RegisteredMobile, Service}
import org.apache.flink.streaming.api.scala.async.JavaResultFutureWrapper

import scala.concurrent.Future

object Application2 extends App {



  override def main(args: Array[String]): Unit = {
lazy val transactor: Resource[IO, HikariTransactor[IO]] =
for {
  ce <- ExecutionContexts.fixedThreadPool[IO](10) // our connect EC
  xa <- HikariTransactor.newHikariTransactor[IO](
            "org.postgresql.Driver",
            "jdbc:postgresql://localhost:5433/local_db",
            "dbuser",
            "dbpassword",
    ce                                      // await connection here
  )
} yield xa
//    val person: Person = Person("mohammad","ezadeh","ali","777","1392/02/02",Gender(true),"342342333")
//    val address: PostalAddress = PostalAddress("poonak",PostalCode("2342342243"),"232434")
//    val service: Service = Service("09127040916","234234",2323,23,234)
//    val registered = RegisteredMobile(address, service, person)
////    val r = mohaymen.onlineprocessing.Subscription.insertRegisteredMobile(registered).transact(t)
//      val r: Ids = transactor.use(t=>
//        for {
//          result <- mohaymen.onlineprocessing.Subscription.insertRegisteredMobile(registered).transact(t)
//        } yield result
//      ).unsafeRunSync()
    val id = "342342334"
//    val query = sql"select 3".query[Int].unique
    val query = sql"""select count(s.mobile_number) FROM
          "Service" as s INNER JOIN
         "Customer" as c
         ON s.customer_id = c.id
         WHERE c.identification_no=$id limit 1 """.query[Int].unique
    val r = transactor.use(t=>
            for {
              result <- query.transact(t)
            } yield result
          ).unsafeRunSync()
    println(r)
    }
}
