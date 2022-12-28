package mohaymen.onlineprocessing.validator
import Configs.AppConfig
import FlinkHelpers.Kafka
import play.api.libs.json.{JsError, JsPath, JsResult, JsValue, Json, JsonValidationError}
import mohaymen.onlineprocessing.{InputRegisteredMobile, RegisteredMobile}
import mohaymen.onlineprocessing.validator.AppliedRules.RegisteredMobileRead
import org.apache.flink.api.common.typeinfo.TypeInformation
import org.apache.flink.streaming.api.scala.{DataStream, createTypeInformation}
import shapeless.HNil
import shapeless._
import HList._
import shapeless.Nat.{_0, _1, _2, _3}

object Validation {
  def map(
           input:DataStream[Kafka.KafkaRecord], configs:AppConfig
         )(
         implicit ot: TypeInformation[Either[(String, FormErrors), RegisteredMobile :: String :: HNil]]
  ): DataStream[Either[(String, FormErrors), RegisteredMobile :: String :: HNil]] ={
    input.map(input => {
      val parsedValue: Either[FormErrors, JsValue] = try{
        Right(Json.parse(input.value))
      }catch {
        case e:com.fasterxml.jackson.core.JsonParseException=>Left(
          FormErrors(
            Seq(
              FieldError("/",
                Seq(
                  "json input is malformed."
                )
              )
            ),"validation"
          )
        )
      }
      parsedValue match {
        case Right(r) =>
          r.validate[InputRegisteredMobile].asEither
            .right.map((rr: InputRegisteredMobile) => rr.toWellFormed :: input.key :: HNil)
            .left.map((ll: Seq[(JsPath, Seq[JsonValidationError])]) => {
            (input.key, fromJsError(JsError(ll)))
          })
        case Left(l: FormErrors) => Left((input.key, l))
      }
    }
    ).setParallelism(configs.parallelism.validation)
  }
}
