

import ObjectMapper

class GetCountriesCities: NSObject{
    class func GetCountriesCities( completionHandler:@escaping([CountriesResp]?,String)->()){
        let url = Constants.WebService.baseUrl + Constants.WebService.getCountries
        
        NetWorkConnection.fetchDataArray(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<CountriesResp>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<CountriesResp>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
    
    
    class func GetCities(id : Int, completionHandler:@escaping([CountriesResp]?,String)->()){
        let url = Constants.WebService.baseUrl + Constants.WebService.getCities + "\(id)"
        
        NetWorkConnection.fetchDataArray(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<CountriesResp>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<CountriesResp>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
    
    
    class func GetAirLines( completionHandler:@escaping([Airlines]?,String)->()){
        let url = Constants.WebService.baseUrl + Constants.WebService.getAirLines
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginContentt
        NetWorkConnection.dataGetWithHeaderArr(url: url, httpmethod: .get, aceessToken: decodedUser.token!, completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<Airlines>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<Airlines>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
    class func GetAirPorts(id : Int, completionHandler:@escaping([Airlines]?,String)->()){
        let url = Constants.WebService.baseUrl + Constants.WebService.airports + "\(id)"
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginContentt
        NetWorkConnection.dataGetWithHeaderArr(url: url, httpmethod: .get, aceessToken: decodedUser.token!, completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<Airlines>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<Airlines>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
    
}










