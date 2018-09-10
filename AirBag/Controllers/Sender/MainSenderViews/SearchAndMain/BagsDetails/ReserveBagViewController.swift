//
//  ReserveBagViewController.swift
//  AirBag
//
//  Created by Geek on 8/20/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit
import Alamofire
var items = [BagItems]()

class ReserveBagViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   

    @IBOutlet weak var reservedTableView: UITableView!
    @IBOutlet weak var reserveBag: UIButton!
    var currentBag : BagDetialsResp?
    var bagId = 0
    var loadedCartStatic : [[String: Any]]?
    var itemName = [String]()
    var recieverName : String?
    
    var weight = [Double]()
    var length = [Double]()
    var width = [Double]()
    var height = [Double]()
    var itemId = [Int]()
    var recieverId : Int?
    var images = [String]()
    var descriptionBag = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
 
        customeCenterImage()
        setUpViews()
      
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.itemName = []
        //self.recieverName = ""
        self.weight = []
        if let favorites = UserDefaults.standard.array(forKey: "\(self.bagId)") {
            if favorites.count == 0 {
                
                
            } else {
//                cart.append(["width": width, "height": height, "weight": weight, "length" : length, "recieverId" : recId, "itemId" : choosenItemIdGlobal, "image" : image , "description" : descrip, "itemName" : itemName, "recieverName" : recName])
                let userDefaults = UserDefaults.standard
                let loadedCart = userDefaults.array(forKey: "\(self.bagId)") as? [[String: Any]]
                self.loadedCartStatic = loadedCart
                for item in self.loadedCartStatic! {
                    self.itemName.append(item["itemName"] as! String)
                     self.recieverName = item["recieverName"] as? String
                    
                     self.weight.append(item["weight"] as! Double)
                     self.height.append(item["height"] as! Double)
                     self.width.append(item["width"] as! Double)
                     self.length.append(item["length"] as! Double)
                    self.recieverId = item["recieverId"] as? Int
                    //self.recieverId.append(item["recieverId"] as! Int)
                    self.itemId.append(item["itemId"] as! Int)
                    self.images.append(item["image"] as! String)
                    self.descriptionBag.append(item["description"] as! String)
                    print(item["itemId"] as! Int)
                }
                self.reservedTableView.reloadData()
            }
        }else{
          
        }
        
        print(self.recieverName ?? "")
    }
    @objc func addItems(){
        performSegue(withIdentifier: "goToAddItems", sender: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if(  self.loadedCartStatic == nil ){
            return 0
        }else{
        return (self.loadedCartStatic?.count)!
      }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell", for: indexPath) as! ItemsTableViewCell
        cell.itemName.text = self.itemName[indexPath.row]
        cell.carrierName.text = self.recieverName
         cell.weight.text = "\(self.weight[indexPath.row])"
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func reserveBagAction(_ sender: Any) {
       // self.navigationController?.popToRootViewController(animated: true)
        print(self.recieverId ?? 90)
        self.creatAlert(tite: "Are you sure you want to reserve these bags?")
         choosenCategoryNameGlobal = ""
         choosenCategoryId = 0
         choosenItemNameGlobal = ""
         choosenItemIdGlobal = 0
    }
    
    
    func setUpViews(){
        let rightBarButton = UIBarButtonItem(title: "Add Items", style: UIBarButtonItemStyle.plain, target: self, action: #selector(addItems))
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.reserveBag.setTitle(ConstantStrings.reserveBag, for: .normal)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "goToAddItems"){
            let destination = segue.destination as! AddItemsInBagViewController
               destination.bagId = self.bagId
            destination.currentBag = self.currentBag
        }
    }
    func creatAlert(tite : String){
        // create the alert
        let alert = UIAlertController(title: tite, message: "", preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            self.reserveBags()
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.destructive, handler: nil ))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }



func reserveBags(){
     print("-------------------")
    print(self.width.count)
       print(self.height.count)
       print(self.weight.count)
       print(self.length.count)
       print(self.images.count)
       print(self.descriptionBag.count)
       print(self.itemId.count)
       print(self.recieverId ?? 0)
    
    ReserveBag.ReserveBag(bagId: self.bagId, weight: self.weight, height: self.height, width: self.width, length: self.length, receiver_id: self.recieverId!, item_id: self.itemId, img: self.images, descriptionString: self.descriptionBag) { (reserveSuccess, error) in
        if(error == ""){
            print("YESS")
        }
    }
}

}




////
//        var materials: [String: Any]?
//var result = [String: Any]()

//        if let  loadedCartStatics = self.loadedCartStatic {
//            for i in 0..<loadedCartStatics.count {
//                let mmap = loadedCartStatics[i]
//
//let material = ["weight[]" : mmap["weight"] as! Double,
//                                    "height[]" : mmap["height"] as! Double,
//                                    "width[]" : mmap["width"] as! Double,
//                                    "length[]" : mmap["length"] as! Double,
//                                    "receiver_id" : mmap["recieverId"] as! Int,
//                                    "item_id[]" : mmap["itemId"] as! Int,
//                                    "img[]" : "dd",
//                                    "description[]" : "dd"] as NSDictionary as! [String : Any]
//                 //print(material)
//                result = material
//
//
//            }
//        }
//        for key in result{
//            print(key.key)
//        }
//print(result)

//let  parameters : Parameters =  ["weight" : [1.1,1.2],  "height" : [1.1,1.2] ,
//                                 "width" : [1.1,1.2] ,
//                                 "length" : [1.1,1.2] ,
//                                 "receiver_id" : 3,
//                                 "item_id" : [1,1],
//                                 "img" : ["dd",""],
//                                 "description" : ["dd",""]]
////print(materials)
//
//
//let userDefaults = UserDefaults.standard
//let decoded  = userDefaults.object(forKey: "logResp") as! Data
//let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginResponse
//print(parameters)
//let authorization = ["Authorization" : "Bearer \(decodedUser.token!)" , "Content-Type" : "application/x-www-form-urlencoded"]
//
//
//NetWorkConnection.dataWithHeader(url: "http://206.189.17.20/bag/reserve/8", httpmethod: .post, aceessToken: decodedUser.token!, parameters: parameters as NSDictionary, completionHandler: {responseObject, error in
//
//    if(error==nil)
//    {
//
//
//    }
//    else
//    {
//
//    }
//});


//        Alamofire.request("http://206.189.17.20/bag/reserve/8", method: .post, parameters: parameters, encoding: JSONEncoding.default ,headers: authorization ).responseJSON(completionHandler: { (response) in
//            print(response)
//            print(response.result)
//        })






