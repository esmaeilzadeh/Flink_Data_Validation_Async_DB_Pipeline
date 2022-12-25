package FlinkHelpers.Kafka

import org.apache.flink.api.common.typeinfo.TypeInformation
import org.apache.flink.streaming.connectors.kafka.KafkaDeserializationSchema
import org.apache.kafka.clients.consumer.ConsumerRecord

class KafkaSchema extends KafkaDeserializationSchema[KafkaRecord] {
  override def isEndOfStream(nextElement: KafkaRecord) = false

  @throws[Exception]
  override def deserialize(record: ConsumerRecord[Array[Byte], Array[Byte]]): KafkaRecord = {
    KafkaRecord((record.key.map(_.toChar)).mkString,(record.value.map(_.toChar)).mkString,record.timestamp)
  }
  override def getProducedType: TypeInformation[KafkaRecord] = TypeInformation.of(classOf[KafkaRecord])
}
