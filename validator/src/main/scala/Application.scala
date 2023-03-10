import Configs.{liveConfigs, liveProperties}
import FlinkHelpers.{Kafka, disJoin}
import FlinkHelpers.Kafka.KafkaStringDeserializer.consumerFromTopic
import FlinkHelpers.Kafka.play.GenericKafkaSerializer.sinkToTopic
import esmaeilzadeh.onlineprocessing
import esmaeilzadeh.onlineprocessing.validator.{Validation, fromJsError}
import esmaeilzadeh.onlineprocessing.{Identification, PolicyCheck, RegisteredMobile, Subscription}
import org.apache.flink.api.common.typeinfo.TypeInformation
import org.apache.flink.streaming.api.scala.{DataStream, StreamExecutionEnvironment, createTypeInformation}
import play.api.libs.json.JsError
import io.circe.generic.auto._
import shapeless._
import HList._
import akka.event.Logging.LogLevel
import com.sun.org.slf4j.internal.Logger
import shapeless.Nat.{_0, _1, _2, _3}
//import org.slf4j.Logger
//import org.slf4j.LoggerFactory

object Application extends App {
//  val logger: Logger = LoggerFactory.getLogger("Application")
  override def main(args: Array[String]): Unit = {

    implicit val typeInfo0 = TypeInformation.of(classOf[(String, Either[JsError, RegisteredMobile])])
    val env = StreamExecutionEnvironment.getExecutionEnvironment
    val configs = liveConfigs.right.get
    println("server started with config:",configs)
    val inputSource = consumerFromTopic(configs.kafkaTopics.input, liveProperties)
    val input = env.addSource(inputSource)
    val (validationFailed,validationPassed) = disJoin(Validation.map(input,configs))
    val (idFailed,idPassed) = disJoin(Identification.map(validationPassed, configs))
    val (policyFailed,policyPassed) = disJoin(PolicyCheck.map(idPassed,configs))
    val (writeInDBFailed,successOutput) = disJoin(Subscription.map(policyPassed, configs))
    val failedOutput = validationFailed union idFailed union policyFailed union writeInDBFailed
    failedOutput.print()
    sinkToTopic(configs.kafkaTopics.failedOutput, failedOutput ,liveProperties)
    successOutput.print()
    sinkToTopic(configs.kafkaTopics.successOutput, convertHListToTuple(successOutput),liveProperties)
    env.execute("online mobile data validating and processing")
  }

  private def convertHListToTuple(writeInDBPassed: DataStream[onlineprocessing.Ids :: RegisteredMobile :: String :: HNil]) = {
    writeInDBPassed.map(x => {
      val ids = x.at(_0)
      (x.at(_2), x.at(_1).augmentWIthIds(ids))
    })
  }
}
