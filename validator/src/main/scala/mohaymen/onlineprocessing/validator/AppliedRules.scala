package mohaymen.onlineprocessing.validator
import DataLayer.models.{Gender, PostalCode}
import FlinkHelpers.Kafka.play.Rules.{allDigits, lengthBetween, verifyOrFail}
import mohaymen.onlineprocessing.{InputRegisteredMobile, InputService, PostalAddressInput}
import play.api.libs.json._
import play.api.libs.json.Reads._
import play.api.libs.functional.syntax._
object AppliedRules {
  //each value consists of validations and transformations related to each field
  implicit val PostalCodeReads: Reads[PostalCode] = (JsPath)
    .read[String](
      allDigits keepAnd  lengthBetween(10,10)
    ).map(PostalCode.apply)
  implicit val GenderReads: Reads[Gender] = (JsPath).read[Int].map(x=>Gender.apply(if(x>0) true else false))
  implicit val AddressRead: Reads[PostalAddressInput] = Json.reads[PostalAddressInput]
  implicit val ServiceRead: Reads[InputService] = Json.reads[InputService]
  implicit val RegisteredMobileRead: Reads[InputRegisteredMobile] = Json.reads[InputRegisteredMobile]

  implicit val PostalCodeWrite: Writes[PostalCode] = Json.valueWrites[PostalCode]
  implicit val GenderWrite: Writes[Gender] = Json.valueWrites[Gender]
  implicit val AddressWrite: Writes[PostalAddressInput] = Json.writes[PostalAddressInput]
  implicit val ServiceWrite: Writes[InputService] = Json.writes[InputService]
  implicit val RegisteredMobileWrite: Writes[InputRegisteredMobile] = Json.writes[InputRegisteredMobile]
}
