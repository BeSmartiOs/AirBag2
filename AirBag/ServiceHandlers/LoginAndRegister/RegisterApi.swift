//
//  RegisterApi.swift
//  AirBag
//
//  Created by Geek on 8/19/18.
//  Copyright © 2018 Geek. All rights reserved.
//
/*
 
 registration_token:cjHsbzBRAfE:APA91bHuJYGVHaEPOBqGiLT7sw9t2VfXLYe3n6Jljz0J3UFa0O4e7USGlocaI3qZvs7Ie3TriAz0jpmlHvDZQsoPWQ1yCMPyoOT4VmRCGvt5OipcpQWRE0hjIJjc-cuRWHo0Txyfz1UnxKEMXiRy4G16-Ckxq_WH4g
 first_name:nour
 last_name:mustafa
 email:nour@gmail.com
 mobile:123456789
 address_city:3421
 address:651456145
 password:Na@12345
 password_confirmation:Na@12345
 frequent_travel_number:1
 favourite_departure_id:1
 favourite_destination_id:2
 credit_card:1231231
 
 
 
 */
import Foundation
import ObjectMapper

class RegisterApi: NSObject{
    class func RegisterApi(fcmToken : String, firstName : String,lastName : String,email : String,mobile : String,addressCityId : Int,address : String,password : String,passwordConfirmation : String,frequentTravelNumber : Int,favouriteDepartureId : Int,favouriteDestinationId : Int,creditCard : String,preferredCategories : [Int], completionHandler:@escaping(ResgisterResp?,String)->()){
        let url = Constants.WebService.baseUrl + Constants.WebService.register
        
        let   parameters = ["registration_token" : fcmToken,"first_name" : firstName,"last_name" : lastName,"email" : email,"mobile" : mobile,"address_city" : addressCityId,"address" : address,"password" : password,"password_confirmation" : passwordConfirmation,"frequent_travel_number" : frequentTravelNumber,"favourite_departure_id" : favouriteDepartureId,"favourite_destination_id" : favouriteDestinationId,"credit_card" : creditCard,"preferred_categories" : preferredCategories ] as [String : Any] as NSDictionary
        print(parameters)
        
        NetWorkConnection.postData(url: url, httpmethod: .post, parameters: parameters as NSDictionary , completionHandler: {responseObject, error in

            if(error==nil)
            {

                let loginResponse = Mapper<ResgisterResp>().map(JSON:responseObject as! [String : Any]) //Swift 3
                if(loginResponse?.msg == "success")
                {
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,(loginResponse?.msg)!)
                }
            }
            else
            {
                completionHandler(Mapper<ResgisterResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
    
    
    
    class func ActivateMobile(code : String, userId : Int, completionHandler:@escaping(PhoneVerificationResp?,String)->()){
        let url = Constants.WebService.baseUrl + Constants.WebService.activateMob + "\(userId)"
        
        let   parameters = ["code" : code] as [String : Any] as NSDictionary
        print(parameters)
        
        NetWorkConnection.postData(url: url, httpmethod: .post, parameters: parameters as NSDictionary , completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                
                let loginResponse = Mapper<PhoneVerificationResp>().map(JSON:responseObject as! [String : Any]) //Swift 3
                if(loginResponse?.msg == "success")
                {
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,(loginResponse?.msg)!)
                }
            }
            else
            {
                completionHandler(Mapper<PhoneVerificationResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
    class func ActivateEmail(code : String, userId : Int, completionHandler:@escaping(PhoneVerificationResp?,String)->()){
        let url = Constants.WebService.baseUrl + Constants.WebService.checkActivation + "\(userId)"
        
        let   parameters = ["code" : code] as [String : Any] as NSDictionary
        print(parameters)
        
        NetWorkConnection.fetchDataDic(url: url, httpmethod: .get, parameters: parameters as NSDictionary , completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                
                let loginResponse = Mapper<PhoneVerificationResp>().map(JSON:responseObject as! [String : Any]) //Swift 3
                if(loginResponse?.msg == "success")
                {
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,(loginResponse?.msg)!)
                }
            }
            else
            {
                completionHandler(Mapper<PhoneVerificationResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
}


