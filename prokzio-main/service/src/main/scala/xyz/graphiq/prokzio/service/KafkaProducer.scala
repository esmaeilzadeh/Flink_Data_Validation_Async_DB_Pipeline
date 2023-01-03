//package xyz.graphiq.prokzio.service
//import org.apache.kafka.clients.producer.{ProducerRecord, RecordMetadata}
//import zio.{Chunk, RIO, Task}
//import zio.blocking.Blocking
//import zio.clock.Clock
//
//object KafkaProducer {
//  trait Service {
//    def produceAndLog(writeTopic: String, records:Chunk[(K,V)]):RIO[Clock with Blocking, Task[Chunk[RecordMetadata]]]
//  }
//}
