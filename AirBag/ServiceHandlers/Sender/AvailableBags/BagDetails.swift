//
//  LoginApi.swift
//  AirBag
//
//  Created by Geek on 8/19/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import Foundation
import ObjectMapper

class BagDetails: NSObject{
    //type= 0
    //  type = 1 filter
    
    class func GetBagDetails(bagId : Int, completionHandler:@escaping(BagDetialsResp?,String)->()){
        let userDefaults = UserDefaults.standard
        let url = Constants.WebService.baseUrl + Constants.WebService.bagInfo + "/\(bagId)"
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginContentt
        NetWorkConnection.dataGetWithHeader(url: url, httpmethod: .get, aceessToken: decodedUser.token!, completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                
                let loginResponse = Mapper<BagDetialsResp>().map(JSON:responseObject as! [String : Any]) //Swift 3
                if(loginResponse?.bagInfo?.count != 0)
                {
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,"error")
                }
            }
            else
            {
                completionHandler(Mapper<BagDetialsResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
}





