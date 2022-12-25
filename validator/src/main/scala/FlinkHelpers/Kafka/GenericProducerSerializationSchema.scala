package FlinkHelpers.Kafka

import org.apache.flink.streaming.connectors.kafka.KafkaSerializationSchema
import org.apache.kafka.clients.producer.ProducerRecord

import java.lang
import java.nio.charset.StandardCharsets

class GenericProducerSerializationSchema[K,V](var topic: String)(implicit keySerializable: io.circe.Encoder[K], valSerializable: io.circe.Encoder[V]) extends KafkaSerializationSchema[GenericKafkaRecordWithoutTimestamp[K,V]] {
  override def serialize(
                          element: GenericKafkaRecordWithoutTimestamp[K,V],
                          timestamp: lang.Long
                        ) =
    new ProducerRecord[Array[Byte], Array[Byte]](
      topic,
      keySerializable(element.key).noSpaces.getBytes(StandardCharsets.UTF_8),
      valSerializable(element.value).noSpaces.getBytes(StandardCharsets.UTF_8))
}