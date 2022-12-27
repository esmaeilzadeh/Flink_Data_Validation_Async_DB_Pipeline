package DataLayer.models
import cats.free.Free
import doobie.free.connection
import doobie.implicits.toSqlInterpolator
import doobie.util.log.LogHandler.jdkLogHandler
import mohaymen.onlineprocessing.PostalAddress

object PostalAddress {
  def getId(record:PostalAddress):doobie.ConnectionIO[Option[Int]] = {
    sql"""select id from "Address" where postal_code=${record.postalCode.value}"""
      .queryWithLogHandler[Int](jdkLogHandler)
      .option
  }
  def insert(record: PostalAddress): doobie.ConnectionIO[Int] = {
    sql"""insert into "Address" (
             address,
             postal_code,
             tel
         ) values (
            ${record.address},
            ${record.postalCode},
            ${record.tel}
          )"""
      .updateWithLogHandler(jdkLogHandler)
      .withUniqueGeneratedKeys[Int]("id")
  }
  def insertOrGetId(record: PostalAddress): Free[connection.ConnectionOp, Int] = {
    DataLayer.insertOrGetId(
      record,
      getId,
      insert
    )
  }
}
