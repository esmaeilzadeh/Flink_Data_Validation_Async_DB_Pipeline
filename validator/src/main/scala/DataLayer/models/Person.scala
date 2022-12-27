package DataLayer.models

import cats.free.Free
import doobie.free.connection
import doobie.implicits.toSqlInterpolator
import doobie.util.log.LogHandler.jdkLogHandler
import mohaymen.onlineprocessing.Person

object Person {
  def getId(record:Person):doobie.ConnectionIO[Option[Int]] = {
    sql"""select id from "Customer" where identification_no=${record.identificationNo}"""
      .queryWithLogHandler[Int](jdkLogHandler)
      .option
  }
  def insert(record: Person): doobie.ConnectionIO[Int] = {
    sql"""insert into "Customer" (
                  name,
                  family,
                  father_name,
                  certification_no,
                  birth_date,
                  gender,
                  identification_no
            ) values (
            ${record.name},
            ${record.family},
            ${record.fatherName},
            ${record.certificationNo},
            ${record.birthDate},
            ${record.gender.value},
            ${record.identificationNo}
            )"""
      .updateWithLogHandler(jdkLogHandler).withUniqueGeneratedKeys[Int]("id")
  }
  def insertOrGetId(record: Person): Free[connection.ConnectionOp, Int] = {
    DataLayer.insertOrGetId(
      record,
      getId,
      insert
    )
  }
}
