//
//    BagInfo.swift
//
//    Create by Geek on 26/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class BagInfo : NSObject, Mappable{
    
    var airlineId : Int?
    var airlineName : String?
    var availableWeight : Int?
    var createdAt : String?
    var deletedAt : AnyObject?
    var departure : Int?
    var departureDatetime : String?
    var departureMobile : String?
    var departureName : String?
    var destination : Int?
    var destinationMobile : AnyObject?
    var destinationName : String?
    var expectedReservedWeight : AnyObject?
    var featured : Int?
    var featuredTill : String?
    var flightNumber : String?
    var id : Int?
    var kgPrice : Int?
    var m3Price : Float?
    var notAvailableFrom : String?
    var notAvailableTo : String?
    var sealed : Int?
    var ticketScan : String?
    var updatedAt : String?
    var views : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return BagInfo()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        airlineId <- map["airline_id"]
        airlineName <- map["airline_name"]
        availableWeight <- map["available_weight"]
        createdAt <- map["created_at"]
        deletedAt <- map["deleted_at"]
        departure <- map["departure"]
        departureDatetime <- map["departure_datetime"]
        departureMobile <- map["departure_mobile"]
        departureName <- map["departure_name"]
        destination <- map["destination"]
        destinationMobile <- map["destination_mobile"]
        destinationName <- map["destination_name"]
        expectedReservedWeight <- map["expected_reserved_weight"]
        featured <- map["featured"]
        featuredTill <- map["featured_till"]
        flightNumber <- map["flight_number"]
        id <- map["id"]
        kgPrice <- map["kg_price"]
        m3Price <- map["m3_price"]
        notAvailableFrom <- map["not_available_from"]
        notAvailableTo <- map["not_available_to"]
        sealed <- map["sealed"]
        ticketScan <- map["ticket_scan"]
        updatedAt <- map["updated_at"]
        views <- map["views"]
        
    }

    
}
