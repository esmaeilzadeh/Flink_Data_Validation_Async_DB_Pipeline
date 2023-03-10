package esmaeilzadeh.onlineprocessing
import Configs.{AppConfig, JdbcConfig}
import DataLayer.models
import FlinkHelpers.AsyncDatabaseQuery
import cats.free.Free
import doobie.free.connection
import doobie.implicits.toSqlInterpolator
import doobie.util.log.LogHandler.jdkLogHandler
import esmaeilzadeh.onlineprocessing.validator.{FieldError, FormErrors}
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
                FormErrors(Seq(FieldError("/", Seq(l.getMessage))),"subscription")
              )
            )
        }
      }
    ).setParallelism(configs.parallelism.subscription)
  }
  def insertRegisteredMobile(in: RegisteredMobile): Free[connection.ConnectionOp, Ids] = {
    for {
      customerId <- models.Person.insertOrGetId(in.person)
      addressId <- models.PostalAddress.insertOrGetId(in.address)
      serviceId <- models.Service.insert(
        in.service.augmentWithId(customerId,addressId)
      )
    } yield Ids(customerId, addressId, serviceId)
  }
}
