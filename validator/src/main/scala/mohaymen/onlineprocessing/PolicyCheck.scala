package mohaymen.onlineprocessing
import Configs.{AppConfig, JdbcConfig}
import FlinkHelpers.AsyncDatabaseQuery
import doobie.implicits.toSqlInterpolator
import mohaymen.onlineprocessing.validator.{FieldError, FormErrors}
import org.apache.flink.streaming.api.scala.{AsyncDataStream, DataStream, createTypeInformation}
import shapeless._
import HList._
import doobie.util.log.LogHandler.jdkLogHandler
import shapeless.Nat.{_0, _1, _2}

object PolicyCheck {
  // returns either (key,error) or (key,input)
  def map(
           successIdentifications:DataStream[RegisteredMobile::String:: HNil],
           configs:AppConfig
         ):
  DataStream[Either[(String, FormErrors), RegisteredMobile::String::HNil]] ={
    val phoneNumPolicyCheck = AsyncDatabaseQuery.augmentWithSingle[RegisteredMobile::String:: HNil,Int](
      successIdentifications, in=>{
        val id = in.at[_0].person.identificationNo
        sql"""select count(s.mobile_number) FROM
          "Service" as s INNER JOIN
         "Customer" as c
         ON s.customer_id = c.id
         WHERE c.identification_no=$id limit 1 """
          .queryWithLogHandler[Int](jdkLogHandler)
          .unique
      },configs.localJdbcConfig)
    phoneNumPolicyCheck.map(x=> {
      x.head match {
        case Left(_) => Right(x.at(_1)::x.at(_2)::HNil)
        case Right(phoneCount: Int) =>
          if(phoneCount>configs.policy.maxPhoneOwned)
            Left(
              (
                x.at(_2),
                FormErrors(Seq(FieldError("service/mobile",Seq("this person already registered all his/her legitimate phone numbers"))))
              )
            )
          else Right(x.at(_1)::x.at(_2)::HNil)
      }
    }
    )
  }
}
