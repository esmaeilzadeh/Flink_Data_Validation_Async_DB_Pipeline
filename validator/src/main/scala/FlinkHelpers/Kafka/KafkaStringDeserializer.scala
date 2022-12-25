package FlinkHelpers.Kafka

import org.apache.flink.api.common.typeinfo.TypeInformation
import org.apache.flink.streaming.connectors.kafka.{FlinkKafkaConsumer, KafkaDeserializationSchema}
import org.apache.kafka.clients.consumer.ConsumerRecord

import java.util.Properties
object KafkaStringDeserializer{
  def consumerFromTopic(topic: String, consumerProperties:Properties): FlinkKafkaConsumer[KafkaRecord] = {
    implicit val typeInfo1: TypeInformation[KafkaRecord] = TypeInformation.of(classOf[KafkaRecord])
    val r: FlinkKafkaConsumer[KafkaRecord] = new FlinkKafkaConsumer[KafkaRecord](
      topic,
      new KafkaStringDeserializer(), consumerProperties
    )
    r
  }
}
class KafkaStringDeserializer extends KafkaDeserializationSchema[KafkaRecord] {

  override def deserialize(record: ConsumerRecord[Array[Byte], Array[Byte]]): KafkaRecord = {
    val key = record.key
    val keyString = if(key==null) "\"\"" else key.map(_.toChar).mkString
    val value = record.value
    val valueString = if(value==null) "\"\"" else value.map(_.toChar).mkString
    val timestamp = record.timestamp()
    KafkaRecord(keyString,valueString,timestamp)
  }

  override def getProducedType: TypeInformation[KafkaRecord] = TypeInformation.of(classOf[KafkaRecord])

  override def isEndOfStream(nextElement: KafkaRecord): Boolean = false

}
