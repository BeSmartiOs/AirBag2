//
//    Content.swift
//
//    Create by Geek on 30/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class RegisterContent : NSObject, NSCoding, Mappable{
    
    var userId : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return RegisterContent()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        userId <- map["user_id"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        userId = aDecoder.decodeObject(forKey: "user_id") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if userId != nil{
            aCoder.encode(userId, forKey: "user_id")
        }
        
    }
    
}

