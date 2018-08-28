//
//  LoginApi.swift
//  AirBag
//
//  Created by Geek on 8/19/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import Foundation
import ObjectMapper

class GetAvailableBags: NSObject{
    //type= 0
  //  type = 1 filter
    class func GetAvailableBags(departureId : Int, destinationId : Int, carrierId : Int,categoryId : Int, airlineId : Int,flightNumber : String,  aceessToken : String,type : Int, completionHandler:@escaping(BagsResponse?,String)->()){
        let url = Constants.WebService.baseUrl + Constants.WebService.availableBags
        var   parameters : [String : Any] = ["" : ""]
        
        if(type == 0){
            parameters = ["" : ""]
            
        }else{
            parameters = (["departure_id" : departureId, "destination_id" : destinationId, "carrier_id" : carrierId, "flight_number" : flightNumber, "category_id" : categoryId, "airline_id": airlineId] as NSDictionary) as! [String : Any]
          
        }
         print(parameters)
        
        NetWorkConnection.dataWithHeader(url: url, httpmethod: .post, aceessToken: aceessToken, parameters: parameters as NSDictionary , completionHandler: {responseObject, error in

            
            
            if(error==nil)
            {

                let loginResponse = Mapper<BagsResponse>().map(JSON:responseObject as! [String : Any]) //Swift 3
                if(loginResponse?.availableFeaturedBags?.count != 0)
                {
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,"error")
                }
            }
            else
            {
                completionHandler(Mapper<BagsResponse>().map(JSON:[:])!,"no_internet");
            }
        });
    }
}




