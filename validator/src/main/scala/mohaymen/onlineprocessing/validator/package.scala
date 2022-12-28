package mohaymen.onlineprocessing

import play.api.libs.json.JsError

package object validator {
  case class FieldError(path:String, errors:Seq[String])
  case class FormErrors(errors:Seq[FieldError],phase:String){
    def ++(other:FormErrors):FormErrors = FormErrors(
      errors ++ other.errors,phase
    )
  }
  object FormErrors{

  }
  def fromJsError(jsErrors:JsError):FormErrors = {
    FormErrors(jsErrors.errors.map(x=>{
      val path: String = x._1.path.map(_.toString).mkString("")
      val errors: Seq[String] = x._2.map(_.message)
      FieldError(path,errors)
    }),"validation")
  }

}
