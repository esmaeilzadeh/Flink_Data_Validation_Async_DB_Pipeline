package FlinkHelpers

package object Kafka {
  case class GenericKafkaRecord[K,V](key: K, value: V, timestamp:Long)
  case class GenericKafkaRecordWithoutTimestamp[K,V](key: K, value: V)
  case class KafkaRecord(key:String,value:String,timestamp:Long)
  case class KafkaRecordWithoutTimestamp(key:String,value:String)
}
