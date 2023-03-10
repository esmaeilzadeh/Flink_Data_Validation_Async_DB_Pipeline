import DataLayer.models.PostalCode
import esmaeilzadeh.onlineprocessing.{InputRegisteredMobile, InputService, MobileNumber, PostalAddressInput}
import FlinkHelpers.Kafka.play.Rules.{allDigits, startWith}
import org.scalatest.funsuite.AnyFunSuite
import play.api.libs.json._
import esmaeilzadeh.onlineprocessing.validator.AppliedRules.RegisteredMobileRead
import esmaeilzadeh.onlineprocessing.validator.AppliedRules.RegisteredMobileWrite

class EncodeDecodeTest extends AnyFunSuite {

  test("encode Decode passed") {
    val decoded =  InputRegisteredMobile(
      PostalAddressInput("No#1 Street 1, ...",PostalCode("1213206313"),"021343333"),
      InputService(
        MobileNumber("09127040915"),
        "432119642587415",
        1,
        0,
        1
      ),
      "asdfasf asdfasfdasdf",
      "fffff ssssss",
      "eeeeeeeeeeeeeeee",
      "234234234234",
      "1378/01/10",
      1,
      "123132123123123"
    )
    val encoded: JsValue = Json.toJson(decoded)
    println(encoded)
    val decodedAgain = encoded.validate[InputRegisteredMobile]
    assert(decodedAgain == JsSuccess(decoded))
  }
  test("encode Decode decode failed because postalCode is wrong") {
    val decoded =  InputRegisteredMobile(
      PostalAddressInput("No#1 Street 1, ...",PostalCode("aaaaaaa"),"021343333"),
      InputService(
        MobileNumber("09127040915"),
        "432119642587415",
        1,
        0,
        1
      ),
      "asdfasf asdfasfdasdf",
      "fffff ssssss",
      "eeeeeeeeeeeeeeee",
      "234234234234",
      "1378/01/10",
      1,
      "123132123123123"
    )
    val encoded: JsValue = Json.toJson(decoded)
    val decodedAgain = encoded.validate[InputRegisteredMobile]
    println(encoded)
    assert(decodedAgain == JsError(
      List((
        __ \ "address" \ "postalCode",
        List(
          JsonValidationError(
            List(
              "this field should only contains digits"
            )
        ),
          JsonValidationError(
            List(
              "length aaaaaaa is lesser than 10"
            )
          ),
        ))
      )
    ))
  }
}
