//
//    PreferredCategory.swift
//
//    Create by Geek on 13/9/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class ProfilePreferedCats : NSObject, Mappable{
    
    var category : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return ProfilePreferedCats()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        category <- map["category"]
        
    }
    

    
}
