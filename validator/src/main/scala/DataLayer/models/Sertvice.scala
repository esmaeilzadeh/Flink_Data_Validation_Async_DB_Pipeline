package DataLayer.models

import cats.free.Free
import doobie.free.connection
import doobie.implicits.toSqlInterpolator
import doobie.util.log.LogHandler.jdkLogHandler
import mohaymen.onlineprocessing.Service

object Sertvice {
  def getId(record:Service):doobie.ConnectionIO[Option[Int]] = {
    sql"""select id from "Service" where mobile_number=${record.mobileNumber}"""
      .queryWithLogHandler[Int](jdkLogHandler)
      .option
  }
  def insert(record: Service): doobie.ConnectionIO[Int] = {
    sql"""insert
                 into "Service"
                   (
                   mobile_number,
                   imsi,
                   sms,
                   data3g,
                   data4g,
                   customer_id
                   )
                 values (
            ${record.mobileNumber},
            ${record.imsi},
            ${record.sms},
            ${record.data3g},
            ${record.data4g},
            ${record.customerId}
          )
                 """
      .updateWithLogHandler(jdkLogHandler)
      .withUniqueGeneratedKeys[Int]("id")
  }
  def insertOrGetId(record: Service): Free[connection.ConnectionOp, Int] = {
    DataLayer.insertOrGetId(
      record,
      getId,
      insert
    )
  }
}
