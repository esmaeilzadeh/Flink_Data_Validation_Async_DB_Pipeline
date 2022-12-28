package mohaymen
package object onlineprocessing {

  case class Service(
                      mobileNumber:String,
                      imsi:String,
                      sms:Boolean,
                      data3g:Boolean,
                      data4g:Boolean,
                      id:Option[Int] = None,
                      customerId:Option[Int] = None,
                      addressId:Option[Int] = None
                    ){
    def augmentWithId(newCustomerId:Int,newAddressId:Int): Service =
      this.copy(
          customerId = Some(newCustomerId),
          addressId = Some(newAddressId)
      )
  }
  case class InputService(mobileNumber:String,
                          imsi:String,
                          sms:Int,
                          data3g:Int,
                          data4g:Int){
    def toWellFormed = Service(
      mobileNumber,
      imsi,
      if(sms>0) true else false,
      if(data3g>0) true else false,
      if(data4g>0) true else false
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
  case class PostalAddressInput(
                            address:String,
                            postalCode:PostalCode,
                            tel:String
                          ) {
    def toWelformed = PostalAddress(
      address:String,
      postalCode:PostalCode,
      tel:String
    )
  }
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
                                    address:PostalAddressInput,
                                    service:InputService,
                                    name:String,
                                    family:String,
                                    fatherName:String,
                                    certificationNo: String,
                                    birthDate:String,
                                    gender:Int,
                                    identificationNo:String
                                  ){
    def toWellFormed:RegisteredMobile = RegisteredMobile(
      address.toWelformed,
      service.toWellFormed,
      Person(
        name,
        family,
        fatherName,
        certificationNo,
        birthDate,
        Gender(if(gender>0) true else false),
        identificationNo
      )
    )
  }
  case class RegisteredMobile(
                              address:PostalAddress,
                              service:Service,
                              person:Person
                             ){
//    def toMalformed:InputRegisteredMobile = InputRegisteredMobile(
//      address,
//      service,
//      person.name,
//      person.family,
//      person.fatherName,
//      person.certificationNo,
//      person.birthDate,
//      person.gender,
//      person.identificationNo
//    )
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
