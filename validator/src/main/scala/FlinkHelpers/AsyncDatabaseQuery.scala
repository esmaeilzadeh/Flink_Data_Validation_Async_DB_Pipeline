package FlinkHelpers

import Configs.JdbcConfig
import doobie.hikari._
import doobie._
import doobie.implicits._
import doobie.util.ExecutionContexts
import cats._
import cats.data._
import cats.effect.IO.asyncForIO
import cats.effect._
import cats.implicits._
import fs2.Stream
import cats.effect.unsafe.implicits.global

import doobie.util.transactor.Transactor.Aux
import org.apache.flink.runtime.concurrent.Executors
import org.apache.flink.streaming.api.scala.async.{AsyncFunction, ResultFuture}

import scala.concurrent.{ExecutionContext, Future}
import scala.reflect.ClassTag
import scala.util.Try
import shapeless._
import HList._
import org.apache.flink.api.common.typeinfo.TypeInformation
import org.apache.flink.streaming.api.scala.{AsyncDataStream, DataStream, createTypeInformation}

import java.util.concurrent.TimeUnit

object AsyncDatabaseQuery {
  def augmentWithSingle[In <: HList, Out: ClassTag](
                                                     inStream: DataStream[In],
                                                     mapping: In => doobie.ConnectionIO[Out],
                                                     config: JdbcConfig
                                                   )(
                                                     implicit ot: TypeInformation[Either[Throwable, Out] :: In]
                                                   ): DataStream[Either[Throwable, Out] :: In] = {
    AsyncDataStream.unorderedWait(
      inStream,
      new AsyncDatabaseQuery[In, Out](config, true) {
        override def query(in: In) = mapping(in)
      }, 10000,
      TimeUnit.MILLISECONDS,
      100
    )
  }
}

abstract class AsyncDatabaseQuery[In <: HList, Out: ClassTag](configs: JdbcConfig, uniqueResult: Boolean) extends AsyncFunction[In, Either[Throwable,Out] :: In] {
  lazy val transactor: Resource[IO, HikariTransactor[IO]] =
    for {
      ce <- ExecutionContexts.fixedThreadPool[IO](configs.poolSize) // our connect EC
      xa <- HikariTransactor.newHikariTransactor[IO](
        configs.driverClassName, // driver classname
        configs.url, // connect URL
        configs.user, // username
        configs.pass, // password
        ce // await connection here
      )
    } yield xa
  //  lazy val transactor: Aux[IO, Unit] = {
  //    Transactor.fromDriverManager[IO](
  //      configs.driverClassName,
  //      configs.url,
  //      configs.user,
  //      configs.pass,
  //    )
  //  }
  /** The context used for the future callbacks */
  implicit lazy val executor: ExecutionContext = ExecutionContext.fromExecutor(Executors.directExecutor())

  def query(in: In): doobie.ConnectionIO[Out]

  override def asyncInvoke(input: In, resultFuture: ResultFuture[Either[Throwable, Out] :: In]): Unit = {
    try {
      val sql = query(input)
      val future = transactor.use { xa =>
        for {
          n <- sql.transact(xa)
        } yield n
      }.unsafeToFuture()
      future.onComplete { (t: Try[Out]) => {
        val value = t.toEither
        value.left.map(x=>println("AsyncDatabase error msg line 84: ", x.getMessage))
        resultFuture.complete(List(value :: input))
      }
      }
    } catch {
      case e: Throwable =>
        println("AsyncDatabase error msg line 90: ", e.getMessage)
        resultFuture.complete(List(Left(e) :: input))
    }
  }

}