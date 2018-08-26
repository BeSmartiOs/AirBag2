//
//  LoginApi.swift
//  AirBag
//
//  Created by Geek on 8/19/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import Foundation
import ObjectMapper
class GetReservations: NSObject{
    class func GetTransactions( completionHandler:@escaping(TransactionsRes?,String)->()){
        let userDefaults = UserDefaults.standard
        let url = Constants.WebService.baseUrl + Constants.WebService.getTransactions
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginResponse
        NetWorkConnection.dataGetWithHeader(url: url, httpmethod: .get, aceessToken: decodedUser.token!, completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                
                let loginResponse = Mapper<TransactionsRes>().map(JSON:responseObject as! [String : Any]) //Swift 3
                if(loginResponse?.transactions?.count != 0)
                {
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,"error")
                }
            }
            else
            {
                completionHandler(Mapper<TransactionsRes>().map(JSON:[:])!,"no_internet");
            }
        });
    }
    
    
    
    class func GetTransactionsDetails(transactionId : Int,completionHandler:@escaping(TransactionDetailsResp?,String)->()){
        let userDefaults = UserDefaults.standard
        let url = Constants.WebService.baseUrl + Constants.WebService.getTransactions + "/\(transactionId)"
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginResponse
        NetWorkConnection.dataGetWithHeader(url: url, httpmethod: .get, aceessToken: decodedUser.token!, completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                
                let loginResponse = Mapper<TransactionDetailsResp>().map(JSON:responseObject as! [String : Any]) //Swift 3
                if(loginResponse?.transaction?.count != 0)
                {
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,"error")
                }
            }
            else
            {
                completionHandler(Mapper<TransactionDetailsResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
}






