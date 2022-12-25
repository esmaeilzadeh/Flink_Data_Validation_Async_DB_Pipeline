import org.apache.flink.api.common.typeinfo.TypeInformation
import org.apache.flink.streaming.api.scala.DataStream

package object FlinkHelpers {
  def disJoin[A,B](input:DataStream[Either[A,B]])(implicit ta: TypeInformation[A], tb: TypeInformation[B]):(DataStream[A],DataStream[B]) = {
    val l = input.filter((x: Either[A, B]) =>x.isLeft).map((x: Either[A, B]) =>x.left.get)
    val r = input.filter((x: Either[A, B]) =>x.isRight).map((x: Either[A, B]) =>x.right.get)
    (l,r)
  }
}
