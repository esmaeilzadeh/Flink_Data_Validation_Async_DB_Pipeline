//package FlinkHelpers
//
//import Configs.JdbcConfig
//import cats.effect.IO.asyncForIO
//import cats.effect._
//import cats.effect.unsafe.implicits.global
//import doobie._
//import doobie.implicits._
//import doobie.util.transactor.Transactor.Aux
//import org.apache.flink.api.common.typeinfo.TypeInformation
//import org.apache.flink.runtime.concurrent.Executors
//import org.apache.flink.streaming.api.scala.{AsyncDataStream, DataStream, createTypeInformation}
//import org.apache.flink.streaming.api.scala.async.{AsyncFunction, ResultFuture}
//import shapeless.HList._
//import shapeless._
//
//import java.util.concurrent.TimeUnit
//import scala.concurrent.{ExecutionContext, Future}
//import scala.reflect.ClassTag
//import scala.util.Try
//
//object AsyncDatabaseUpdate {
//  def augmentWithSingle[In <: HList,Out](
//                                      inStream: DataStream[In],
//                                      mapping: In => doobie.ConnectionIO[Out],
//                                      config: JdbcConfig
//                                    )(
//    implicit ot: TypeInformation[Either[String, Out] :: In]
//  ): DataStream[Either[String, Out] :: In] = {
//    AsyncDataStream.unorderedWait(
//      inStream,
//      new AsyncDatabaseUpdate[In,Out](config) {
//        override def query(in: In) = mapping(in)
//      }, 1000,
//      TimeUnit.MILLISECONDS,
//      100
//    )
//  }
//}
//
///**
// * return type: Either[String,Int]: if error happens returns String and
// * if the update runs successfully returns number of affected rows
// */
//abstract class AsyncDatabaseUpdate[In <: HList,Out](configs: JdbcConfig) extends AsyncFunction[In, Either[String, Out] :: In] {
//  lazy val transactor: Aux[IO, Unit] = {
//    Transactor.fromDriverManager[IO](
//      configs.driverClassName,
//      configs.url,
//      configs.user,
//      configs.pass,
//    )
//  }
//  /** The context used for the future callbacks */
//  implicit lazy val executor: ExecutionContext = ExecutionContext.fromExecutor(Executors.directExecutor())
//
//  def query(in: In): doobie.ConnectionIO[Out]
//
//  override def asyncInvoke(input: In, resultFuture: ResultFuture[Either[String, Out] :: In]): Unit = {
//    val sql = query(input)
//
//    val future: Future[Out] = sql.transact(transactor).unsafeToFuture()
//
//    future.onComplete { (t: Try[Out]) =>
//      t.toEither match {
//        case Right(result) =>
//          println(result)
//          resultFuture.complete(List(Right(result) :: input))
//
//        case Left(t) =>
//          println("AsyncDatabase error msg: ", t.getMessage)
//          resultFuture.complete(List(Left(t.getMessage) :: input))
//
//      }
//    }
//  }
//
//}