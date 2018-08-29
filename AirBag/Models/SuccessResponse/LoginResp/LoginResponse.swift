//
//    RootClass.swift
//
//    Create by Geek on 29/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class LoginResponse : NSObject, Mappable{
    
    var content : LoginContentt?
    var errorMsgs : ErrorMsg?
    var msg : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return LoginResponse()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        content <- map["content"]
        errorMsgs <- map["errorMsgs"]
        msg <- map["msg"]
        
    }
    

    
}
