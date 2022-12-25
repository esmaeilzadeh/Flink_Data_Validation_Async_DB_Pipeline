package mohaymen.onlineprocessing.validator
//import io.circe.generic.auto._
//import io.circe.syntax._
//import mohaymen.onlineprocessing.validator.Rules.{allDigits, startWith}
//import mohaymen.onlineprocessing.{Address, PostalCode, RegisteredMobile, Service}
//import play.api.libs.json._
//import play.api.libs.json.Reads._
//import play.api.libs.functional.syntax._
import mohaymen.onlineprocessing.validator.Rules.allDigits
import mohaymen.onlineprocessing.{Gender, InputRegisteredMobile, PostalAddress, PostalCode, Service}
import play.api.libs.json._
import play.api.libs.json.Reads._
import play.api.libs.functional.syntax._
import play.api.libs.json.JsPath.read
object AppliedRules {
  implicit val PostalCodeReads: Reads[PostalCode] = (JsPath).read[String](allDigits).map(PostalCode.apply)
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
