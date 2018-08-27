//
//  UsersResp.swift
//  AirBag
//
//  Created by Geek on 8/27/18.
//  Copyright © 2018 Geek. All rights reserved.
//
//    RootClass.swift
//
//    Create by Geek on 27/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class UsersResp : NSObject, Mappable{
    
    var id : Int?
    var nickname : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return UsersResp()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["id"]
        nickname <- map["nickname"]
        
    }
    
  
    
}
