//
//    RootClass.swift
//
//    Create by Geek on 30/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class ResgisterResp : NSObject, NSCoding, Mappable{
    
    var content : RegisterContent?
    var errorMsgs : RegisterErrorMsg?
    var msg : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return ResgisterResp()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        content <- map["content"]
        errorMsgs <- map["errorMsgs"]
        msg <- map["msg"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        content = aDecoder.decodeObject(forKey: "content") as? RegisterContent
        errorMsgs = aDecoder.decodeObject(forKey: "errorMsgs") as? RegisterErrorMsg
        msg = aDecoder.decodeObject(forKey: "msg") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if content != nil{
            aCoder.encode(content, forKey: "content")
        }
        if errorMsgs != nil{
            aCoder.encode(errorMsgs, forKey: "errorMsgs")
        }
        if msg != nil{
            aCoder.encode(msg, forKey: "msg")
        }
        
    }
    
}
