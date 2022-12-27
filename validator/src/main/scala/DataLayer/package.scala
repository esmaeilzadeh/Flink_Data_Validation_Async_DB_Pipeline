import cats.free.Free
import doobie.free.connection
import doobie.implicits.toSqlInterpolator

package object DataLayer {
  def upsert[A, ID](
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
  def insertOrGetId[A, ID](
                            record: A,
                            getId: A => doobie.ConnectionIO[Option[ID]],
                            insert: A => doobie.ConnectionIO[ID]
                   ): Free[connection.ConnectionOp, ID] = {
    for {
      existingId <- getId(record)
      id <- existingId match {
        case None => insert(record)
        case Some(p: ID) => sql"$p".query[ID].unique
      }
    } yield id
  }
}
