//
//    BasicInfo.swift
//
//    Create by Geek on 13/9/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class ProfileBasicInfo : NSObject, Mappable{
    
    var activationCode : String?
    var active : Int?
    var address : String?
    var addressCity : Int?
    var authyId : AnyObject?
    var createdAt : String?
    var creditCard : String?
    var currentTypeId : Int?
    var deletedAt : AnyObject?
    var email : String?
    var emailActivation : AnyObject?
    var favouriteDepartureId : Int?
    var favouriteDestinationId : Int?
    var firstName : String?
    var frequentTravelNumber : Int?
    var id : Int?
    var lastName : String?
    var mobile : String?
    var mobileActivation : AnyObject?
    var nickname : String?
    var registrationToken : String?
    var updatedAt : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return ProfileBasicInfo()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        activationCode <- map["activation_code"]
        active <- map["active"]
        address <- map["address"]
        addressCity <- map["address_city"]
        authyId <- map["authy_id"]
        createdAt <- map["created_at"]
        creditCard <- map["credit_card"]
        currentTypeId <- map["current_type_id"]
        deletedAt <- map["deleted_at"]
        email <- map["email"]
        emailActivation <- map["email_activation"]
        favouriteDepartureId <- map["favourite_departure_id"]
        favouriteDestinationId <- map["favourite_destination_id"]
        firstName <- map["first_name"]
        frequentTravelNumber <- map["frequent_travel_number"]
        id <- map["id"]
        lastName <- map["last_name"]
        mobile <- map["mobile"]
        mobileActivation <- map["mobile_Activation"]
        nickname <- map["nickname"]
        registrationToken <- map["registration_token"]
        updatedAt <- map["updated_at"]
        
    }
  
}
