//
//    ErrorMsg.swift
//
//    Create by Geek on 30/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class PhoneErrorMsg : NSObject, NSCoding, Mappable{
    
    
    
    class func newInstance(map: Map) -> Mappable?{
        return PhoneErrorMsg()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        
    }
    
}
