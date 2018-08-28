//
//  Constants.swift
//  AirBag
//
//  Created by Geek on 8/15/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import Foundation
struct Constants{
    
    struct UserType{
        static let carrier = 1
        static let sender = 2
        static let reciever = 3
        
    }
    
    struct WebService{
        static let baseUrl = "http://206.189.17.20"
        static let getCountries = "/countries"
        static let getCategories = "/categories"
        static let getCities = "/cities/"
        static let register = "/register"
        static let login = "/login"
         static let availableBags = "/availableBags"
        static let bagInfo = "/bagInfo"
         static let getTransactions = "/currentTransactions"
        static let getUsers  = "/users"
         static let items  = "/items"
        static let reserveBag = "/bag/reserve"
         static let getAirLines = "/airlines"
        
    }
    
}
