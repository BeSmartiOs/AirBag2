//
//  LoginResponse.swift
//  AirBag
//
//  Created by Geek on 8/19/18.
//  Copyright © 2018 Geek. All rights reserved.
//

//
//    RootClass.swift
//
//    Create by Geek on 19/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class LoginResponse : NSObject, NSCoding, Mappable{
    
    var active : Int?
    var currentTypeID : String?
    var nickname : String?
    var token : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return LoginResponse()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        active <- map["active"]
        currentTypeID <- map["currentTypeID"]
        nickname <- map["nickname"]
        token <- map["token"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        active = aDecoder.decodeObject(forKey: "active") as? Int
        currentTypeID = aDecoder.decodeObject(forKey: "currentTypeID") as? String
        nickname = aDecoder.decodeObject(forKey: "nickname") as? String
        token = aDecoder.decodeObject(forKey: "token") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if active != nil{
            aCoder.encode(active, forKey: "active")
        }
        if currentTypeID != nil{
            aCoder.encode(currentTypeID, forKey: "currentTypeID")
        }
        if nickname != nil{
            aCoder.encode(nickname, forKey: "nickname")
        }
        if token != nil{
            aCoder.encode(token, forKey: "token")
        }
        
    }
    
}
