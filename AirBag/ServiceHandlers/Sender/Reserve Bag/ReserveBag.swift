//
//  ReserveBag.swift
//  AirBag
//
//  Created by Geek on 8/28/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import Foundation
import ObjectMapper
import UIKit

class ReserveBag: NSObject{
    class func ReserveBag(bagId : Int, weight : [Double], height : [Double],width : [Double],length : [Double],receiver_id : Int,item_id : [Int],img : [String],descriptionString : [String], completionHandler:@escaping(ReserveResultResp?,String)->()){
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginResponse
        let url = Constants.WebService.baseUrl + Constants.WebService.reserveBag + "/\(bagId)"
        let  parameters =  ["weight" : weight,  "height" : height ,
                                         "width" : width ,
                                         "length" : length ,
                                         "receiver_id" : receiver_id,
                                         "item_id" : item_id,
                                         "img" : img,
                                         "description" : descriptionString] as [String : Any] as NSDictionary
        print(parameters)
        
        NetWorkConnection.dataWithHeader(url: url, httpmethod: .post, aceessToken: decodedUser.token!, parameters: parameters as NSDictionary , completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                
                let loginResponse = Mapper<ReserveResultResp>().map(JSON:responseObject as! [String : Any]) //Swift 3
                if(loginResponse?.success == 1)
                {
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,"error")
                }
            }
            else
            {
                completionHandler(Mapper<ReserveResultResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
}


