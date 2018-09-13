//
//    RootClass.swift
//
//    Create by Geek on 13/9/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class ProfileResponse : NSObject, Mappable{
    
    var basicInfo : [ProfileBasicInfo]?
    var preferredCategories : [ProfilePreferedCats]?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return ProfileResponse()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        basicInfo <- map["basicInfo"]
        preferredCategories <- map["preferredCategories"]
        
    }
   
    
}
