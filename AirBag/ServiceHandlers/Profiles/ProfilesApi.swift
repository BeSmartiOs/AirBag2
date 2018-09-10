//
//  GetRecievers.swift
//  AirBag
//
//  Created by Geek on 8/27/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import Foundation
import ObjectMapper

class ProfilesApi: NSObject{
    class func GetProfiles( completionHandler:@escaping(UsersResp?,String)->()){
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginContentt
        let url = Constants.WebService.baseUrl + Constants.WebService.getProfile
        
        NetWorkConnection.dataGetWithHeader(url: url, httpmethod: .get, aceessToken: decodedUser.token!, completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                     Mapper<UsersResp>().map(JSON:responseObject as! [String : Any]) //Swift 3
                if(subCat?.id != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                 completionHandler(Mapper<UsersResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
    
    
    class func EditProfiles(first_name : String, last_name: String, email: String, mobile: String  ,  address_city : Int , frequent_travel_number: Int,  address: String ,favourite_departure_id: Int, favourite_destination_id: Int, credit_card: String , preferred_categories :[Int], completionHandler:@escaping(UsersResp?,String)->()){
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginContentt
        let url = Constants.WebService.baseUrl + Constants.WebService.editProfile
        
        /**first_name (string) , *last_name(string) ,
         *email(string) ,
         *mobile(string) , *address_city(city_id)(int) ,
         frequent_travel_number (int), address (string) ,
         favourite_departure_id(city_id) (int),
         favourite_destination_id (int) (city_id),
         credit_card (string) ,
         preferred_categories[](array of categories ids)  (int[])*/
        
        /* first_name : String, last_name: String, email: String, mobile: String  ,  address_city : Int , frequent_travel_number: Int,  address: String ,favourite_departure_id: Int, favourite_destination_id: Int, credit_card: String , preferred_categories*/
        
        let  parameters =  ["first_name" : first_name,"last_name" : last_name,"email" : email,"mobile" : mobile  , "address_city" : address_city ,"frequent_travel_number" : frequent_travel_number, "address" : address ,"favourite_departure_id" :favourite_departure_id,"favourite_destination_id" : favourite_destination_id,"credit_card"  : credit_card , "preferred_categories" :preferred_categories] as [String : Any] as NSDictionary
        NetWorkConnection.dataWithHeader(url: url, httpmethod: .post, aceessToken: decodedUser.token!, parameters: parameters, completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<UsersResp>().map(JSON:responseObject as! [String : Any]) //Swift 3
                if(subCat?.id != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<UsersResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
    
    
    
}


