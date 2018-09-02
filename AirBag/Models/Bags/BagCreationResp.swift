//
//  BagCreationResp.swift
//  AirBag
//
//  Created by Geek on 9/2/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import Foundation
//
//    RootClass.swift
//
//    Create by Geek on 2/9/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class BagCreationResp : NSObject, Mappable{
    
    var bagID : Int?
    var msg : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return BagCreationResp()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        bagID <- map["bagID"]
        msg <- map["msg"]
        
    }
    
    
}
