package mohaymen

import DataLayer.models.{Gender, Person, PostalAddress, PostalCode, Service}

package object onlineprocessing {
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
