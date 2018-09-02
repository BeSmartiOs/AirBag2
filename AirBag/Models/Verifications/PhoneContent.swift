//
//    Content.swift
//
//    Create by Geek on 30/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class PhoneContent : NSObject, NSCoding, Mappable{
    
    var active : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return PhoneContent()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        active <- map["active"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        active = aDecoder.decodeObject(forKey: "active") as? Int
        
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
        
    }
    
}
