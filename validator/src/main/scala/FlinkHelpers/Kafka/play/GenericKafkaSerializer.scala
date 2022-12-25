package FlinkHelpers.Kafka.play
import FlinkHelpers.Kafka.{GenericKafkaRecord, GenericKafkaRecordWithoutTimestamp, GenericProducerSerializationSchema}
import io.circe.Encoder
import org.apache.flink.api.common.typeinfo.TypeInformation
import org.apache.flink.streaming.api.scala.DataStream
import org.apache.flink.streaming.connectors.kafka.FlinkKafkaProducer.Semantic
import org.apache.flink.streaming.connectors.kafka.{FlinkKafkaProducer, KafkaSerializationSchema}
import org.apache.kafka.clients.producer.ProducerRecord
import java.lang
import java.nio.charset.StandardCharsets
import java.util.Properties
import io.circe.generic.codec.DerivedAsObjectCodec.deriveCodec
object GenericKafkaSerializer{
  def sinkToTopic[K, V](topic: String, stream: DataStream[(K, V)],properties:Properties,semantic:Semantic=Semantic.EXACTLY_ONCE)(implicit encoderK: Encoder[K], encoderV: Encoder[V]): Unit = {
    implicit val typeInfo1: TypeInformation[GenericKafkaRecordWithoutTimestamp[K, V]] = TypeInformation.of(classOf[GenericKafkaRecordWithoutTimestamp[K, V]])
    val kafkaMappedData = stream.map((x: (K, V)) => GenericKafkaRecordWithoutTimestamp[K, V](x._1, x._2))
    val producer = new FlinkKafkaProducer[GenericKafkaRecordWithoutTimestamp[K, V]](
      topic, new GenericProducerSerializationSchema[K, V](topic), properties,semantic)
    kafkaMappedData.addSink(producer)
  }
}
class GenericKafkaSerializer[K,V](var topic: String)(implicit keySerializable: io.circe.Encoder[K], valSerializable: io.circe.Encoder[V]) extends KafkaSerializationSchema[GenericKafkaRecord[K,V]] {
  override def serialize(
                          element: GenericKafkaRecord[K,V],
                          timestamp: lang.Long
                        ) =
    new ProducerRecord[Array[Byte], Array[Byte]](
      topic,
      keySerializable(element.key).noSpaces.getBytes(StandardCharsets.UTF_8),
      valSerializable(element.value) .noSpaces.getBytes(StandardCharsets.UTF_8))
}