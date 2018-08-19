//
//  LoginApi.swift
//  AirBag
//
//  Created by Geek on 8/19/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginApi: NSObject{
    class func LoginApi(email : String, currentTypeId : Int, password : String, completionHandler:@escaping(LoginResponse?,String)->()){
        let url = Constants.WebService.baseUrl + Constants.WebService.login
        
        let   parameters = ["email" : email, "password" : password, "current_type_id" : currentTypeId] as [String : Any] as NSDictionary
        print(parameters)
        
        NetWorkConnection.postData(url: url, httpmethod: .post, parameters: parameters as NSDictionary , completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                
                let loginResponse = Mapper<LoginResponse>().map(JSON:responseObject as! [String : Any]) //Swift 3
                if(loginResponse?.token != "")
                {
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,"error")
                }
            }
            else
            {
                completionHandler(Mapper<LoginResponse>().map(JSON:[:])!,"no_internet");
            }
        });
    }
}



