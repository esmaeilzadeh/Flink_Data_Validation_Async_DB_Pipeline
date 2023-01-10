package DataLayer.models

import cats.free.Free
import doobie.free.connection
import doobie.implicits.toSqlInterpolator
import doobie.util.log.LogHandler.jdkLogHandler
import esmaeilzadeh.onlineprocessing.MobileNumber
case class Service(
                    mobileNumber:MobileNumber,
                    imsi:String,
                    sms:Boolean,
                    data3g:Boolean,
                    data4g:Boolean,
                    id:Option[Int] = None,
                    customerId:Option[Int] = None,
                    addressId:Option[Int] = None
                  ){
  def augmentWithId(newCustomerId:Int,newAddressId:Int): Service =
    this.copy(
      customerId = Some(newCustomerId),
      addressId = Some(newAddressId)
    )
}
object Service {
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
                   customer_id,
                   address_id
                   )
                 values (
            ${record.mobileNumber.value},
            ${record.imsi},
            ${record.sms},
            ${record.data3g},
            ${record.data4g},
            ${record.customerId},
            ${record.addressId}
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
