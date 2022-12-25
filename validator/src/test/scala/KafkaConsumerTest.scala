//import FlinkHelpers.Kafka.play.GenericKafkaDeserializer.{decodeKeyAndValue, parseAndValidate, parseJson, validateJson}
//import mohaymen.onlineprocessing.{Address, PostalCode, RegisteredMobile, Service}
//import mohaymen.onlineprocessing.validator.AppliedRules.RegisteredMobileRead
//import org.scalatest.funsuite.AnyFunSuite
//import play.api.libs.json.{JsValue, Json}
//import org.scalatest.funsuite.AnyFunSuite
//import play.api.libs.json._
//import mohaymen.onlineprocessing.validator.AppliedRules.RegisteredMobileRead
//import mohaymen.onlineprocessing.validator.AppliedRules.RegisteredMobileWrite
//class KafkaConsumerTest extends AnyFunSuite {
//  test("GenericKafkaDeserializer.parseAndValidate for object field") {
//    val decoded =  RegisteredMobile(
//      Address("No#1 Street 1, ...",PostalCode("12312313"),"021343333"),
//      Service(
//        "09127040915",
//        "432119642587415",
//        1,
//        0,
//        1
//      ),
//      "asdfasf asdfasfdasdf",
//      "fffff ssssss",
//      "eeeeeeeeeeeeeeee",
//      "234234234234",
//      "1378/01/10",
//      true,
//      "123132123123123"
//    )
//    val encoded: JsValue = Json.toJson(decoded)
//    val valueStr="{\"address\":{\"address\":\"No#1 Street 1, ...\",\"postalCode\":\"aaaaaaa\",\"tel\":\"021343333\"},\"service\":{\"mobileNumber\":\"09127040915\",\"imsi\":\"432119642587415\",\"sms\":1,\"data3g\":0,\"data4g\":1},\"name\":\"asdfasf asdfasfdasdf\",\"family\":\"fffff ssssss\",\"fatherName\":\"eeeeeeeeeeeeeeee\",\"certificationNo\":\"234234234234\",\"birthDate\":\"1378/01/10\",\"gender\":true,\"identificationNo\":\"123132123123123\"}"
//    val parsed = parseJson(encoded.toString, "value is not well formated")
//    assert(
//      validateJson[RegisteredMobile](parsed) == Right(decoded)
//    )
//  }
//  test("GenericKafkaDeserializer.parseAndValidate for string field") {
//    val value:String= "a b c"
//    val parsed = parseAndValidate[String](value, "value is not well formated")
//    assert(parsed==Right(value))
//  }
//  test("GenericKafkaDeserializer.decodeKeyAndValue for string,Object field") {
//    val key:String= ""
//    val decoded =  RegisteredMobile(
//      Address("No#1 Street 1, ...",PostalCode("12312313"),"021343333"),
//      Service(
//        "09127040915",
//        "432119642587415",
//        1,
//        0,
//        1
//      ),
//      "asdfasf asdfasfdasdf",
//      "fffff ssssss",
//      "eeeeeeeeeeeeeeee",
//      "234234234234",
//      "1378/01/10",
//      true,
//      "123132123123123"
//    )
//    val encoded: JsValue = Json.toJson(decoded)
//    val parsed = decodeKeyAndValue[String,RegisteredMobile](key,encoded.toString())
//    assert(parsed==Right((key,decoded)))
//  }
//}
