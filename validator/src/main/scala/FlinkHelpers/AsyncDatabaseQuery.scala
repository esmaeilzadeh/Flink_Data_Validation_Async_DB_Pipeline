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
                                                     implicit ot: TypeInformation[Option[Out] :: In]
                                                   ): DataStream[Option[Out] :: In] = {
    AsyncDataStream.unorderedWait(
      inStream,
      new AsyncDatabaseQuery[In, Out](config, true) {
        override def query(in: In) = mapping(in)
      }, 1000,
      TimeUnit.MILLISECONDS,
      100
    )
  }
}

abstract class AsyncDatabaseQuery[In <: HList, Out: ClassTag](configs: JdbcConfig, uniqueResult: Boolean) extends AsyncFunction[In, Option[Out] :: In] {
  lazy val transactor: Resource[IO, HikariTransactor[IO]] =
    for {
      ce <- ExecutionContexts.fixedThreadPool[IO](configs.poolSize) // our connect EC
      xa <- HikariTransactor.newHikariTransactor[IO](
        configs.driverClassName,                        // driver classname
        configs.url,   // connect URL
        configs.user,                                   // username
        configs.pass,                                     // password
        ce                                      // await connection here
      )
    } yield xa
//// for test without pool
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

  override def asyncInvoke(input: In, resultFuture: ResultFuture[Option[Out]:: In]): Unit = {
    try {
    val sql = query(input)
//    val future: Future[Out] = sql.transact(transactor).unsafeToFuture()
      val future: Future[Out] = transactor.use { xa =>
        for {
          n <- sql.transact(xa)
        } yield n
      }.unsafeToFuture()
      future.onComplete { (t: Try[Out]) =>
        t.toEither match {
          case Right(result) =>
            println(result)
            resultFuture.complete(List(Some(result) :: input))

          case Left(e) =>
            println("AsyncDatabase error msg: ", e.getMessage)
            resultFuture.complete(List(None :: input))
        }
      }
    }catch{
      case e: Throwable =>
        println("AsyncDatabase error msg: ", e.getMessage)
        resultFuture.complete(List(None :: input))
    }

  }

}