

import ObjectMapper

class GetCategories: NSObject{
    class func GetCategories( completionHandler:@escaping([CategoryResp]?,String)->()){
        let url = Constants.WebService.baseUrl + Constants.WebService.getCategories
        
        NetWorkConnection.fetchDataArray(url: url, httpmethod: .post, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<CategoryResp>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<CategoryResp>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
    
    
    
    class func GetCategoriesItems(catId : Int, completionHandler:@escaping([ItemsInCategResp]?,String)->()){
        let url = Constants.WebService.baseUrl + Constants.WebService.items + "/\(catId)"
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginResponse
        NetWorkConnection.dataGetWithHeaderArr(url: url, httpmethod: .get, aceessToken: decodedUser.token!, completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<ItemsInCategResp>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<ItemsInCategResp>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
    
    
    
    class func GetCategoriesParams( bagId : Int, completionHandler:@escaping([CategoryResp]?,String)->()){
        let url = Constants.WebService.baseUrl + Constants.WebService.getCategories
           let   parameters = ["bag_id" : bagId ] as [String : Any] as NSDictionary
        print(parameters)
        NetWorkConnection.postDataArr(url: url, httpmethod: .post, parameters: parameters as NSDictionary, completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<CategoryResp>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<CategoryResp>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
    
    
}











