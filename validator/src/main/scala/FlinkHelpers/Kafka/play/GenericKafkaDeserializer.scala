//package FlinkHelpers.Kafka.play
//import FlinkHelpers.Kafka.GenericKafkaRecord
//import FlinkHelpers.Kafka.play.GenericKafkaDeserializer.decodeKeyAndValue
//import play.api.libs.json._
//import com.fasterxml.jackson.core.JsonParseException
//import org.apache.flink.api.common.typeinfo.TypeInformation
//import org.apache.flink.streaming.connectors.kafka.{FlinkKafkaConsumer, KafkaDeserializationSchema}
//import org.apache.kafka.clients.consumer.ConsumerRecord
//import scala.reflect.runtime.universe._
//
//import java.util.Properties
//object GenericKafkaDeserializer{
//  def consumerFromTopic[K:TypeTag, V:TypeTag](topic: String, consumerProperties:Properties)(
//    implicit rdsK: Reads[K],rdsV: Reads[V]
//  ): FlinkKafkaConsumer[Either[JsError, GenericKafkaRecord[K, V]]] = {
//    implicit val typeInfo1: TypeInformation[GenericKafkaRecord[K, V]] = TypeInformation.of(classOf[GenericKafkaRecord[K, V] ])
//    implicit val typeInfo2: TypeInformation[Either[JsError, GenericKafkaRecord[K, V]]] = TypeInformation.of(classOf[Either[JsError, GenericKafkaRecord[K, V]]])
//      val r: FlinkKafkaConsumer[Either[JsError, GenericKafkaRecord[K, V]]] = new FlinkKafkaConsumer[Either[JsError, GenericKafkaRecord[K, V]]](
//        topic,
//        new GenericKafkaDeserializer[K, V](), consumerProperties
//      )
//    r
//  }
//
//  def decodeKeyAndValue[K:TypeTag,V:TypeTag](keyString: String, valueString: String)(
//    implicit rdsK: Reads[K],rdsV: Reads[V]
//  ):Either[JsError, (K, V)] = {
//    val keyError = "input key is not a valid Json."
//    val key:Either[JsError, K] = parseAndValidate[K](keyString, keyError)
//    val valueError = "input value is not a valid Json."
//    val value:Either[JsError, V]  = parseAndValidate[V](valueString, valueError)
//    //@todo test
//    key match {
//      case Right(k) =>
//        value match {
//          case Right(v) => Right(k, v)
//          case Left(ve: JsError) => Left(ve)
//        }
//      case Left(ke: JsError) => value match {
//        case Right(_) => Left(ke)
//        case Left(ve: JsError) => Left(ve++ke)
//      }
//    }
//  }
//
//  def parseAndValidate[A: TypeTag](keyString: String, keyError: String)(implicit rk:Reads[A]): Either[JsError, A] = {
//    typeOf[A] match{
//      case s if s =:= typeOf[String] => validateJson[A](Right(Json.toJson[String](keyString)))
//      case _ => validateJson[A](parseJson(keyString, keyError))
//    }
//  }
//
//  def validateJson[A](parsedJson: Either[JsError, JsValue])(implicit rdsK: Reads[A] ): Either[JsError, A] = {
//    parsedJson
//      .flatMap(
//        (keyJson: JsValue) =>
//          keyJson
//            .validate[A]
//            .asEither
//            .left
//            .map(
//              x => JsError(x)
//            )
//      )
//  }
//
//  def parseJson(input: String, error:String): Either[JsError, JsValue] = {
//    try {
//      Right(Json.parse(input))
//    } catch {
//      case e: JsonParseException => Left(JsError(error))
//    }
//  }
//}
//
//
//
//class GenericKafkaDeserializer[K:TypeTag,V:TypeTag](rdsK: Reads[K],rdsV: Reads[V]) extends KafkaDeserializationSchema[Either[JsError, GenericKafkaRecord[K, V]]] {
//
//  @throws[Exception]
//  override def deserialize(record: ConsumerRecord[Array[Byte], Array[Byte]]): Either[JsError, GenericKafkaRecord[K, V]] = {
//    implicit val rdsk2 = rdsK
//    implicit val rdsv2 = rdsV
//    val key = record.key
//    val keyString = if(key==null) "\"\"" else key.map(_.toChar).mkString
//    val value = record.value
//    val valueString = if(value==null) "\"\"" else value.map(_.toChar).mkString
//    val timestamp = record.timestamp()
//
//    val eitherKV: Either[JsError, (K, V)] = decodeKeyAndValue[K,V](keyString, valueString)
//    eitherKV.map((kv: (K, V)) =>GenericKafkaRecord(kv._1,kv._2,timestamp))
//  }
//
//  override def isEndOfStream(nextElement: Either[JsError, GenericKafkaRecord[K, V]]): Boolean = false
//
//  override def getProducedType: TypeInformation[Either[JsError, GenericKafkaRecord[K, V]]] = TypeInformation.of(classOf[Either[JsError, GenericKafkaRecord[K, V]]])
//}