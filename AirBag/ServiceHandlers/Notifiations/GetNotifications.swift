//
//  GetNotifications.swift
//  AirBag
//
//  Created by Geek on 8/29/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import Foundation
import Foundation
import ObjectMapper

class GetNotifications: NSObject{
    class func GetNotifications( completionHandler:@escaping(NotificationResp?,String)->()){
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginContentt
        let url = Constants.WebService.baseUrl + Constants.WebService.notifications
        
        NetWorkConnection.dataGetWithHeader(url: url, httpmethod: .get, aceessToken: decodedUser.token!, completionHandler: {responseObject, error in
            
            
            if(error==nil)
            {
                
                let loginResponse = Mapper<NotificationResp>().map(JSON:responseObject as! [String : Any]) //Swift 3
                if(loginResponse?.msg == "success")
                {
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,(loginResponse?.msg)!)
                }
            }
            else
            {
                completionHandler(Mapper<NotificationResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
    
    class func GetNotificationsDetails(notificationId : Int, completionHandler:@escaping(NotificationDetailsResp?,String)->()){
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginContentt
        let url = Constants.WebService.baseUrl + Constants.WebService.notifications + "/\(notificationId)"
        
        NetWorkConnection.dataGetWithHeader(url: url, httpmethod: .get, aceessToken: decodedUser.token!, completionHandler: {responseObject, error in
            
            
            if(error==nil)
            {
                
                let loginResponse = Mapper<NotificationDetailsResp>().map(JSON:responseObject as! [String : Any]) //Swift 3
                if(loginResponse?.id != 0)
                {
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,"error")
                }
            }
            else
            {
                completionHandler(Mapper<NotificationDetailsResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
}

