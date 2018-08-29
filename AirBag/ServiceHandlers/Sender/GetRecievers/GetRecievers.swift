//
//  GetRecievers.swift
//  AirBag
//
//  Created by Geek on 8/27/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import Foundation
import ObjectMapper

class GetRecievers: NSObject{
    class func GetRecievers( completionHandler:@escaping([UsersResp]?,String)->()){
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginContentt
        let url = Constants.WebService.baseUrl + Constants.WebService.getUsers
        
        NetWorkConnection.dataGetWithHeaderArr(url: url, httpmethod: .get, aceessToken: decodedUser.token!, completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<UsersResp>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<UsersResp>().mapArray(JSONObject: []),"no_internet");
            }
        });
}
}

