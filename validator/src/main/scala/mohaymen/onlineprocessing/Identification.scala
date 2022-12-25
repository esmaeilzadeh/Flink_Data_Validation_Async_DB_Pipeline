package mohaymen.onlineprocessing
import Configs.AppConfig
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

    val identificationStep1: DataStream[Option[Person] :: RegisteredMobile :: String :: HNil] =
      AsyncDatabaseQuery.augmentWithSingle[RegisteredMobile :: String :: HNil,Person](validationPassed, in=>{
        val id = in.at[_0].person.identificationNo
        //                     name:String,
        //                     family:String,
        //                     fatherName:String,
        //                     certificationNo: String,
        //                     birthDate:String,
        //                     gender:Boolean,
        //                     identificationNo:String,
        sql"select name, family, fatherName, certificationNo, birthDate, identification_no from people where identification_no=$id limit 1"
          .queryWithLogHandler[Person](jdkLogHandler)
          .unique
      },configs.globalJdbcConfig)


    val identificationStep2: DataStream[Option[PostalAddress]::Option[Person]  :: RegisteredMobile :: String :: HNil] = {

      AsyncDatabaseQuery.augmentWithSingle[Option[Person] :: RegisteredMobile :: String :: HNil,PostalAddress](identificationStep1, in=>{
        val pd = in.at[_1].address.postalCode
        //                            address:String,
        //                            postalCode:PostalCode,
        //                            tel:String,
        sql"select address, postal_code, tel from postal_addresses where postal_code=$pd limit 1 "
          .queryWithLogHandler[PostalAddress](jdkLogHandler)
          .unique
      },configs.globalJdbcConfig)
    }
    identificationStep2.map(
      (i: Option[PostalAddress] :: Option[Person] :: RegisteredMobile :: String :: HNil) => {
        val addressEither: Either[FormErrors, PostalAddress] = i.at[_0] match {
          case None => Left(FormErrors(Seq(FieldError("address", Seq("not found in db.")))))
          case Some(v) => {
            if (v == i.at(_2).address)
              Right(v)
            else
              Left(
                FormErrors(Seq(FieldError("address", Seq("not found in db."))))
              )
          }
        }
        val personEither: Either[FormErrors, Person] = i.at[_1] match {
          case None => Left(FormErrors(Seq(FieldError("person", Seq("not found in db.")))))
          case Some(v) => Right(v)
        }
        personEither match {
          case Right(_) =>
            addressEither match {
              case Right(_) => Right(i.at[_2] :: i.at[_3] :: HNil)
              case Left(ve) => Left((i.at[_3], ve))
            }
          case Left(ke) => addressEither match {
            case Right(_) => Left((i.at[_3], ke))
            case Left(ve) => Left((i.at[_3], ve ++ ke))
          }
        }
      }
    )
  }
}
