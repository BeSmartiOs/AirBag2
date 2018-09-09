import Foundation
import ObjectMapper
import UIKit

class CretaeBag: NSObject{
    class func CretaeBag(type : Int,bagId : Int, available_weight : Double , kg_price : Double ,m3_price : Double, departure_mobile : String, destination_mobile : String, flight_number : String, featured : Int , featured_till : String, ticket_scan : String, departure  : Int , destination : Int , airline_id  : Int , departure_datetime : String, categories_restrictions : [Int],
        new_categories : [String], not_available_from : String, not_available_to : String, completionHandler:@escaping(BagCreationResp?,String)->()){
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginContentt
        var url = ""
        let  parameters =  ["available_weight" : available_weight , "kg_price" : kg_price ,"m3_price" : m3_price, "departure_mobile" : departure_mobile, "destination_mobile" : destination_mobile, "flight_number" : flight_number, "featured" : featured , "featured_till" : featured_till, "ticket_scan" : ticket_scan, "departure"  : departure , "destination" : destination , "airline_id"  : airline_id , "departure_datetime" : departure_datetime, "categories_restrictions" : categories_restrictions,
                            "new_categories" : new_categories, "not_available_from" : not_available_from, "not_available_to" : not_available_to] as [String : Any] as NSDictionary
       
        
        print(parameters)
        
        if(type == 2){ //add
            url = Constants.WebService.baseUrl + Constants.WebService.createBag
        }else{ //edit
             url = Constants.WebService.baseUrl + Constants.WebService.editBag + "\(bagId)"
        }
        
        NetWorkConnection.dataWithHeader(url: url, httpmethod: .post, aceessToken: decodedUser.token!, parameters: parameters as NSDictionary , completionHandler: {responseObject, error in

            if(error==nil)
            {
                let loginResponse = Mapper<BagCreationResp>().map(JSON:responseObject as! [String : Any]) //Swift 3
                if(loginResponse?.bagID != 0)
                {
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,"error")
                }
            }
            else
            {
                completionHandler(Mapper<BagCreationResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
    
    
    
    
    
    class func GetCarrierBags( completionHandler:@escaping(BagDetialsResp?,String)->()){
        let userDefaults = UserDefaults.standard
        let url = Constants.WebService.baseUrl + Constants.WebService.userBags
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginContentt
        NetWorkConnection.dataGetWithHeader(url: url, httpmethod: .get, aceessToken: decodedUser.token!, completionHandler: {responseObject, error in
            if(responseObject?.value(forKey:"error") != nil)
            {
                completionHandler(Mapper<BagDetialsResp>().map(JSON:[:])!,Constants.UserType.tokenExpired)
            }
            else
            if(error == nil)
            {
                
                let loginResponse = Mapper<BagDetialsResp>().map(JSON:responseObject as! [String : Any]) //Swift 3
                if(loginResponse?.bagInfo != nil)
                {
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,"token_expired")
                }
            }
            else
            {
                completionHandler(Mapper<BagDetialsResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
    
    class func sealBag( bagId : Int, completionHandler:@escaping(SuccessResponse?,String)->()){
        let userDefaults = UserDefaults.standard
        let url = Constants.WebService.baseUrl + Constants.WebService.sealBAg + "\(bagId)"
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginContentt
        NetWorkConnection.dataGetWithHeader(url: url, httpmethod: .post, aceessToken: decodedUser.token!, completionHandler: {responseObject, error in
            
            if(error == nil)
            {
                
                let loginResponse = Mapper<SuccessResponse>().map(JSON:responseObject as! [String : Any]) //Swift 3   msg = "your bag has been sealed ";
                if(loginResponse?.msg == "your bag has been sealed ")
                {
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,"error")
                }
            }
            else
            {
                completionHandler(Mapper<SuccessResponse>().map(JSON:[:])!,"no_internet");
            }
        });
    }
}



