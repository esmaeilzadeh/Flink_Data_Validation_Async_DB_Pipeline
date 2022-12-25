package mohaymen.onlineprocessing.validator
import com.fasterxml.jackson.core.JsonParseException
import mohaymen.onlineprocessing.InputRegisteredMobile
import org.apache.flink.api.common.functions.MapFunction
import play.api.libs.json.{JsError, JsValue, Json}
class ValidatorFunction extends MapFunction[String,Either[FormErrors,InputRegisteredMobile]]{
  import mohaymen.onlineprocessing.validator.AppliedRules.RegisteredMobileRead
  override def map(value: String): Either[FormErrors, InputRegisteredMobile] = {
    try {
      val json: JsValue = Json.parse(value)
      Right(json.validate[InputRegisteredMobile].get)
    } catch {
      case e: JsonParseException => {
        println()
        Left(FormErrors(Seq(FieldError("/",Seq("input data is not a well formed JSON.")))))
      }
    }
  }
}
