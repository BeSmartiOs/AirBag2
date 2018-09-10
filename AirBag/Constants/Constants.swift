
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
        static let tokenExpired = "token_expired"
    }
    
    
    /*
     0- just registered
     1- only mobile activation is done
     2- only email activation is done
     3- email and mobile activation are done
     .. user can open app now
     */
    
    struct WebService{
          /*BAseUrl*/
        static let baseUrl = "http://206.189.17.20"
        /*Authintications*/
        static let register = "/register"
        static let login = "/login"
        static let activateMob = "/activateMobile/"
        static let checkActivation = "/checkActivation/"
        static let logoutFromApp = "/logout"
        static let changeUserType = "/userType"
        
        /*Common*/
        static let getCountries = "/countries"
        static let getCategories = "/categories"
        static let getCities = "/cities/"
        static let availableBags = "/availableBags"
        static let bagInfo = "/bagInfo"
        static let getTransactions = "/currentTransactions"
        static let getUsers  = "/users"
        static let getProfile  = "/profile"
        static let editProfile  = "/profile/edit"
        static let items  = "/items"
        static let getAirLines = "/airlines"
        static let notifications = "/notifications"
        static let airports = "/airports/"

        /*Carrier*/
        static let createBag = "/bag/create"
        static let editBag = "/bag/edit/"
        static let userBags = "/userBags"
        static let sealBAg = "/bag/seal/"
        
        /*Sender*/
         static let reserveBag = "/bag/reserve"
}
}
