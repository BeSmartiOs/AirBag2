//
//	ErrorMsg.swift
//
//	Create by Geek on 20/8/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class ErrorMsg : NSObject, NSCoding, Mappable{

	var email : [String]?


	class func newInstance(map: Map) -> Mappable?{
		return ErrorMsg()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		email <- map["email"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         email = aDecoder.decodeObject(forKey: "email") as? [String]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}

	}

}