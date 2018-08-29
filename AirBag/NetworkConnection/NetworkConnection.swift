//
//  NetworkConnection.swift
//  AirBag
//
//  Created by Geek on 8/16/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import Foundation
import Alamofire

class NetWorkConnection: NSObject {
    /*no headers*/
    static func fetchDataDic( url:String,httpmethod:HTTPMethod,parameters:NSDictionary,completionHandler:@escaping(NSDictionary?, String?) -> ()){
        Alamofire.request(url, method: httpmethod, parameters: nil, headers:nil).responseJSON { response in
            print("Request \(String(describing: response.request))")
            print("RESPONSE \(String(describing:response.result.value))")
            print("RESPONSE \(response.result)")
            print("RESPONSE \(response)")
            switch response.result {
            case .success:
                completionHandler(response.result.value as!NSDictionary?,nil)
                break
            case .failure:
                completionHandler([:],"no_internet")
                break
            }
        }
}
    
    static func fetchDataArray( url:String,httpmethod:HTTPMethod,parameters:NSDictionary,completionHandler:@escaping(NSArray?, String?) -> ()){
        
        Alamofire.request(url, method: httpmethod, parameters: nil, headers:nil).responseJSON { response in
            print("Request \(String(describing: response.request))")
            print("RESPONSE \(String(describing:response.result.value))")
            print("RESPONSE \(response.result)")
            print("RESPONSE \(response)")
            switch response.result {
            case .success:
                completionHandler(response.result.value as! NSArray?,nil)
                break
            case .failure:
                completionHandler([],"no_internet")
                break
            }
        }
    }
    
    static func postData( url:String,httpmethod:HTTPMethod, parameters:NSDictionary,completionHandler: @escaping (NSDictionary?, String?) -> ()){
        
        Alamofire.request(url, method: httpmethod, parameters: parameters as? Parameters, encoding: JSONEncoding.default ,headers: nil ).responseJSON { response in
            print("Request  \(String(describing: response.request))")
            print("RESPONSE \(String(describing: response.result.value))")
            print("RESPONSE \(response.result)")
            print("RESPONSE \(response)")
            switch response.result {
            case .success:
                completionHandler(response.result.value as! NSDictionary?,nil)
                break
            case .failure:
                completionHandler([:],"no_internet")
                break
            }
        }
    }
    
    static func postDataArr( url:String,httpmethod:HTTPMethod, parameters:NSDictionary,completionHandler: @escaping (NSArray?, String?) -> ()){
        
        Alamofire.request(url, method: httpmethod, parameters: parameters as? Parameters, encoding: JSONEncoding.default ,headers: nil ).responseJSON { response in
            print("Request  \(String(describing: response.request))")
            print("RESPONSE \(String(describing: response.result.value))")
            print("RESPONSE \(response.result)")
            print("RESPONSE \(response)")
            switch response.result {
            case .success:
                completionHandler(response.result.value as! NSArray?,nil)
                break
            case .failure:
                completionHandler([],"no_internet")
                break
            }
        }
    }
     /* headers*/
    static func dataWithHeader( url:String,httpmethod:HTTPMethod,aceessToken : String, parameters:NSDictionary,completionHandler: @escaping (NSDictionary?, String?) -> ()){
        
        let authorization = ["Authorization" : "Bearer \(aceessToken)"]
        
        Alamofire.request(url, method: httpmethod, parameters: parameters as? Parameters, encoding: JSONEncoding.default ,headers: authorization ).responseJSON { response in
            print("Request  \(String(describing: response.request))")
            print("RESPONSE \(String(describing: response.result.value))")
            print("RESPONSE \(response.result)")
            print("RESPONSE \(response)")
            switch response.result {
            case .success:
                completionHandler(response.result.value as! NSDictionary?,nil)
                break
            case .failure:
                completionHandler([:],"no_internet")
                break
            }
        }
    }

    
    static func dataGetWithHeader( url:String,httpmethod:HTTPMethod,aceessToken : String,completionHandler: @escaping (NSDictionary?, String?) -> ()){
        
        let authorization = ["Authorization" : "Bearer \(aceessToken)"]
        
        Alamofire.request(url, method: httpmethod, parameters: nil, encoding: JSONEncoding.default ,headers: authorization ).responseJSON { response in
            print("Request  \(String(describing: response.request))")
            print("RESPONSE \(String(describing: response.result.value))")
            print("RESPONSE \(response.result)")
            print("RESPONSE \(response)")
            switch response.result {
            case .success:
                completionHandler(response.result.value as! NSDictionary?,nil)
                break
            case .failure:
                completionHandler([:],"no_internet")
                break
            }
        }
    }

    static func dataGetWithHeaderArr( url:String,httpmethod:HTTPMethod,aceessToken : String,completionHandler: @escaping (NSArray?, String?) -> ()){
        
        let authorization = ["Authorization" : "Bearer \(aceessToken)"]
        
        Alamofire.request(url, method: httpmethod, parameters: nil, encoding: JSONEncoding.default ,headers: authorization ).responseJSON { response in
            print("Request  \(String(describing: response.request))")
            print("RESPONSE \(String(describing: response.result.value))")
            print("RESPONSE \(response.result)")
            print("RESPONSE \(response)")
            switch response.result {
            case .success:
                completionHandler(response.result.value as! NSArray?,nil)
                break
            case .failure:
                completionHandler([],"no_internet")
                break
            }
        }
    }
    
    
   

}
