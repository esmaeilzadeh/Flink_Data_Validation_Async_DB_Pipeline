package FlinkHelpers.Kafka.play

import play.api.libs.json.Reads.pattern
import play.api.libs.json.{JsError, JsSuccess, JsValue, Reads}

object Rules {
  def allDigits(implicit reads: Reads[String]): Reads[String] =
    pattern(
      """^[0-9]*$""".r
      , "this field should only contains digits")

  def verifyOrFail[I, O](f: I => Either[String, O])(implicit reads: Reads[I]): Reads[O] = {
    Reads[O]((i: JsValue) =>
      reads.reads(i).flatMap(
        ii => f(ii) match {
          case Left(l) => JsError(l)
          case Right(r) => JsSuccess(r)
        }
      ))
  }

  def startWith(start: String)(implicit reads: Reads[String]): Reads[String] = {
    verifyOrFail(
      (
        (i: String) =>
          if (i.startsWith(start))
            Right(i)
          else
            Left("this field is not started with " + start)
        )
    )
  }

  def lengthBetween(min: Int, max: Int)(implicit reads: Reads[String]): Reads[String] = {
    verifyOrFail(
      (
        (i: String) => {
          (i.length > min - 1, i.length < max + 1) match {
            case (true, true) => Right(i)
            case (false, true) => Left(s"length ${i} is lesser than " + min)
            case (true, false) => Left(s"length ${i} is greater than " + max)
            case (false, false) => Left("max and min is not correctly set.")
          }
        }
        )
    )
  }
}
