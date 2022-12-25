package mohaymen.onlineprocessing.validator
import io.circe.generic.auto._
import io.circe.syntax._
import mohaymen.onlineprocessing.{PostalAddress, InputRegisteredMobile}
import play.api.libs.json._
import play.api.libs.json.Reads._
import play.api.libs.functional.syntax._
object Rules {
  def allDigits(implicit reads: Reads[String]): Reads[String] =
    pattern(
      """^[0-9]*$""".r
      ,"this field should only contains digits")
  def verifyOrFail[I,O](f: I =>Option[O], error:String)(implicit reads:Reads[I]):Reads[O] = {
    Reads[O](i =>
      reads.reads(i).flatMap(
        ii=> f(ii) match {
          case None => JsError(error)
          case Some(iii) => JsSuccess(iii)
        }
      ))
  }
  def startWith(start:String)(implicit reads: Reads[String]): Reads[String] = {
    verifyOrFail(
      (
        (i:String) =>
          if(i.startsWith(start))
            Some(i)
          else
            None
        ),"this field is not started with "+start
    )
  }
}
