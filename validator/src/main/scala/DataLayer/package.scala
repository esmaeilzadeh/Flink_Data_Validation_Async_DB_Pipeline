import cats.free.Free
import doobie.free.connection
import doobie.implicits.toSqlInterpolator

import scala.reflect.ClassTag

package object DataLayer {
  def upsert[A, ID:ClassTag](
                     record: A,
                     getExistingId: A => doobie.ConnectionIO[Option[ID]],
                     insert: A => doobie.ConnectionIO[ID],
                     update: (ID, A) => doobie.ConnectionIO[ID]
                   ): Free[connection.ConnectionOp, ID] = {
    for {
      existingId <- getExistingId(record)
      id <- existingId match {
        case None => insert(record)
        case Some(p: ID) =>
          update(p, record)
      }
    } yield id
  }
  def insertOrGetId[A, ID:ClassTag](
                            record: A,
                            getId: A => doobie.ConnectionIO[Option[ID]],
                            insert: A => doobie.ConnectionIO[ID]
                   )(implicit oid:Ordering[ID]): Free[connection.ConnectionOp, ID] = {
    for {
      existingId <- getId(record)
      id <- existingId match {
        case None => insert(record)
        case Some(p: ID) => Free.pure[connection.ConnectionOp,ID](p)
      }
    } yield id
  }
}
