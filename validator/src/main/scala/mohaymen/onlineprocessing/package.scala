package mohaymen
package object onlineprocessing {

  case class Service(
                      mobileNumber:String,
                      imsi:String,
                      sms:Short,
                      data3g:Short,
                      data4g:Short,
                      id:Option[Int] = None,
                      customerId:Option[Int] = None
                    ){
    def augmentWithId(newCustomerId:Int): Service =
      this.copy(
        customerId = Some(newCustomerId)
      )
  }
  case class PostalCode(value:String)
  case class PostalAddress(
                            address:String,
                            postalCode:PostalCode,
                            tel:String,
                            id:Option[Int]=None,
                            customerId:Option[Int]=None
                          )
  //0:male,1:female
  case class Gender(value:Boolean)
  case class Person(
                     name:String,
                     family:String,
                     fatherName:String,
                     certificationNo: String,
                     birthDate:String,
                     gender:Gender,
                     identificationNo:String,
                     id:Option[Int] = None
                   )

  case class InputRegisteredMobile(
                                    address:PostalAddress,
                                    service:Service,
                                    name:String,
                                    family:String,
                                    fatherName:String,
                                    certificationNo: String,
                                    birthDate:String,
                                    gender:Gender,
                                    identificationNo:String
                                  ){
    def toWellFormed:RegisteredMobile = RegisteredMobile(
      address,
      service,
      Person(
        name,
        family,
        fatherName,
        certificationNo,
        birthDate,
        gender,
        identificationNo
      )
    )
  }
  case class RegisteredMobile(
                              address:PostalAddress,
                              service:Service,
                              person:Person
                             ){
    def toMalformed:InputRegisteredMobile = InputRegisteredMobile(
      address,
      service,
      person.name,
      person.family,
      person.fatherName,
      person.certificationNo,
      person.birthDate,
      person.gender,
      person.identificationNo
    )
    def augmentWIthIds(ids:Ids):RegisteredMobile = {
      this.copy(
        person=person.copy(id=Some(ids.personId)),
        address=address.copy(id=Some(ids.addressId),customerId = Some(ids.personId)),
        service=service.copy(id=Some(ids.serviceId),customerId = Some(ids.personId))
      )
    }
  }
  case class Ids(personId:Int,addressId:Int,serviceId:Int)
}
