package esmaeilzadeh.onlineprocessing.validator
import DataLayer.models.{Gender, PostalCode}
import FlinkHelpers.Kafka.play.Rules.{allDigits, allowedValues, lengthBetween, startWith, verifyOrFail}
import esmaeilzadeh.onlineprocessing.{InputRegisteredMobile, InputService, MobileNumber, PostalAddressInput}
import play.api.libs.json._
import play.api.libs.json.Reads._
import play.api.libs.functional.syntax._
object AppliedRules {
  //each value consists of validations and transformations related to each field
  implicit val PostalCodeReads: Reads[PostalCode] = (JsPath)
    .read[String](
      allDigits keepAnd  lengthBetween(10,10)
    ).map(PostalCode.apply)
  implicit val GenderReads: Reads[Gender] = (JsPath).read[Int](allowedValues(List(0,1))).map ({
    case 0 => Gender.apply(false)
    case 1 => Gender.apply(true)
  })

  implicit val AddressRead: Reads[PostalAddressInput] = Json.reads[PostalAddressInput]
  implicit val ServiceRead:Reads[InputService] = (
    (JsPath \ "mobileNumber").read[String](lengthBetween(11,11)).map(MobileNumber) and
    (JsPath \ "imsi").read[String](lengthBetween(15,15)) and
    (JsPath \ "sms").read[Int](allowedValues(List(0,1))) and
    (JsPath \ "data3g").read[Int](allowedValues(List(0,1))) and
      (JsPath \ "data4g").read[Int](allowedValues(List(0,1)))
    )(InputService.apply _)
  implicit val RegisteredMobileRead: Reads[InputRegisteredMobile] = Json.reads[InputRegisteredMobile]

  implicit val PostalCodeWrite: Writes[PostalCode] = Json.valueWrites[PostalCode]
  implicit val GenderWrite: Writes[Gender] = Json.valueWrites[Gender]
  implicit val AddressWrite: Writes[PostalAddressInput] = Json.writes[PostalAddressInput]
  implicit val MobileNumberWrite: Writes[MobileNumber] = Json.writes[MobileNumber]
  implicit val ServiceWrite: Writes[InputService] = Json.writes[InputService]
  implicit val RegisteredMobileWrite: Writes[InputRegisteredMobile] = Json.writes[InputRegisteredMobile]
}
