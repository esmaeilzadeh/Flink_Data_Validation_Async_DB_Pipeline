package mohaymen.onlineprocessing.validator
import FlinkHelpers.Kafka.play.Rules.{allDigits, lengthBetween, verifyOrFail}
import mohaymen.onlineprocessing.{Gender, InputRegisteredMobile, PostalAddress, PostalCode, Service}
import play.api.libs.json._
import play.api.libs.json.Reads._
import play.api.libs.functional.syntax._
object AppliedRules {
  //each value consists of validations and transformations related to each field
  implicit val PostalCodeReads: Reads[PostalCode] = (JsPath)
    .read[String](
      allDigits keepAnd  lengthBetween(10,10)
    ).map(PostalCode.apply)
  implicit val GenderReads: Reads[Gender] = (JsPath).read[Boolean].map(Gender.apply)
  implicit val AddressRead: Reads[PostalAddress] = Json.reads[PostalAddress]
  implicit val ServiceRead: Reads[Service] = Json.reads[Service]
  implicit val RegisteredMobileRead: Reads[InputRegisteredMobile] = Json.reads[InputRegisteredMobile]

  implicit val PostalCodeWrite: Writes[PostalCode] = Json.valueWrites[PostalCode]
  implicit val GenderWrite: Writes[Gender] = Json.valueWrites[Gender]
  implicit val AddressWrite: Writes[PostalAddress] = Json.writes[PostalAddress]
  implicit val ServiceWrite: Writes[Service] = Json.writes[Service]
  implicit val RegisteredMobileWrite: Writes[InputRegisteredMobile] = Json.writes[InputRegisteredMobile]
}
