import pureconfig.ConfigReader.Result
import pureconfig._
import pureconfig.error.ConfigReaderFailures
import pureconfig.generic.auto._

import java.util.Properties
import scala.util.Try

package object Configs {
  case class KafkaServerConfig(host:String, port:Int, groupId:String)
  case class KafkaTopics(
                          input:String,
                          successOutput:String,
                          failedOutput:String
                        )
  case class JdbcConfig(driverClassName: String,
                        url:             String,
                        user:            String,
                        pass:            String,
                        poolSize:Int
                      )
  case class PhoneRegisteringPolicy(maxPhoneOwned:Int)
  case class ParallelismCnf(
                             validation:Int,
                             identification:Int,
                             policyCheck:Int,
                             subscription:Int
                           )
  case class AppConfig(
                        kafkaServer: KafkaServerConfig,
                        kafkaTopics: KafkaTopics,
                        globalJdbcConfig:JdbcConfig,
                        localJdbcConfig:JdbcConfig,
                        policy:PhoneRegisteringPolicy,
                        parallelism: ParallelismCnf
                      )
  val liveConfigs: Result[AppConfig] = ConfigSource.default.load[AppConfig]
  val tryLiveConfigs: Try[AppConfig] = liveConfigs.left.map(x=>new Error(x.toList.map(_.toString).foldLeft("")((acc: String, b: String) => acc + b))).toTry
  val liveProperties: Properties = {
    val properties: Properties = new Properties()
    val kafkaServer = Configs.tryLiveConfigs.get.kafkaServer
    properties.setProperty("bootstrap.servers", kafkaServer.host + ":" + kafkaServer.port)
    properties.setProperty("group.id", kafkaServer.groupId)
    properties
  }
}
