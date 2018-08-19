

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
}











