package mohaymen.onlineprocessing
import Configs.AppConfig
import DataLayer.models.{Person, PostalAddress}
import FlinkHelpers.AsyncDatabaseQuery
import doobie.implicits._
import mohaymen.onlineprocessing.validator.{FieldError, FormErrors, fromJsError}
import org.apache.flink.streaming.api.scala.{DataStream, createTypeInformation}
import shapeless._
import HList._
import doobie.util.Read
import doobie.util.Read._
import doobie.util.log.LogHandler.jdkLogHandler
import shapeless.Nat.{_0, _1, _2, _3}

import scala.reflect.runtime.universe._
object Identification {

  def classAccessors[T: TypeTag]: List[MethodSymbol] = typeOf[T].members.collect {
    case m: MethodSymbol if m.isCaseAccessor => m
  }.toList
  def map(validationPassed: DataStream[RegisteredMobile :: String :: HNil],configs:AppConfig): DataStream[Either[(String, FormErrors), RegisteredMobile :: String :: HNil]] = {

    val withPerson: DataStream[Either[Throwable,Person] :: RegisteredMobile :: String :: HNil] =
      AsyncDatabaseQuery.augmentWithSingle[RegisteredMobile :: String :: HNil,Person](
        validationPassed,
        in=>{
        val id = in.at[_0].person.identificationNo
        sql"select name, family, father_name, certification_no, birth_date, gender, identification_no,null from people where identification_no=$id limit 1"
          .queryWithLogHandler[Person](jdkLogHandler)
          .unique
      },
        configs.globalJdbcConfig
      )


    val withAddressAndPerson: DataStream[Either[Throwable,PostalAddress]::Either[Throwable,Person]  :: RegisteredMobile :: String :: HNil] = {

      AsyncDatabaseQuery.augmentWithSingle[Either[Throwable,Person] :: RegisteredMobile :: String :: HNil,PostalAddress](withPerson, in=>{
        val address = in.at[_1].address
        val pd = address.postalCode.value
        sql"select address, postal_code, tel,null,null from postal_addresses where postal_code=$pd limit 1 "
          .queryWithLogHandler[PostalAddress](jdkLogHandler)
          .unique
      },configs.globalJdbcConfig)
    }
    withAddressAndPerson.map(
      (i: Either[Throwable,PostalAddress]::Either[Throwable,Person] :: RegisteredMobile :: String :: HNil) => {
        val addressEither: Either[FormErrors, PostalAddress] = i.at[_0] match {
          case Left(l) => Left(FormErrors(Seq(FieldError("address", Seq(l.getMessage))),"identification"))
          case Right(v) => Right(v)
        }
        val personEither: Either[FormErrors, Person] = i.at[_1] match {
          case Left(l) => Left(FormErrors(Seq(FieldError("person", Seq(l.getMessage))),"identification"))
          case Right(v) => Right(v)
        }
        personEither match {
          case Right(p) =>
            addressEither match {
              case Right(a) => {
                val rm = i.at(_2)
                val key = i.at(_3)
                val result: Either[(String, FormErrors), RegisteredMobile :: String :: HNil] = (a==rm.address,p==rm.person) match {
                  case (true,true) => Right( rm::key::HNil )
                  case (false,true) =>Left(
                    (key,FormErrors(Seq(FieldError("address", Seq("details is not match input: "+rm.address+" not equal to "+a))),"identification"))
                  )
                  case (true,false) =>Left(
                    (key,FormErrors(Seq(FieldError("person", Seq("details is not match input: "+rm.person+" not equal to "+p))),"identification"))
                  )
                  case (false,false) =>Left(
                    (key,FormErrors(Seq(
                      FieldError("address", Seq("details is not match.")),
                      FieldError("person", Seq("details is not match."))
                    ),"identification"))
                  )
                }
                result
              }
              case Left(ve) => Left((i.at[_3], ve))
            }
          case Left(ke) => addressEither match {
            case Right(_) => Left((i.at[_3], ke))
            case Left(ve) => Left((i.at[_3], ve ++ ke))
          }
        }
      }
    ).setParallelism(configs.parallelism.identification)
  }
}
