//
//  AddItemsInBagViewController.swift
//  AirBag
//
//  Created by Geek on 8/20/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit
import JGProgressHUD

//MARK:- Global
var choosenCategoryName = ""
var choosenCategoryId = 0
var choosenItemName = ""
var choosenItemId = 0


class AddItemsInBagViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    

    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var weightLabel : UILabel!
    @IBOutlet weak var heightText: UITextField!
    @IBOutlet weak var heightLabel : UILabel!
    @IBOutlet weak var widthText: UITextField!
    @IBOutlet weak var widthLabel : UILabel!
    @IBOutlet weak var lengthText: UITextField!
    @IBOutlet weak var lengthLabel : UILabel!
    @IBOutlet weak var chooseCategoryItemBtn: UIButton!
    @IBOutlet weak var choosenCategoryItemLabe: UILabel!
    @IBOutlet weak var choosenReciever: UIButton!
    @IBOutlet weak var recievers: UITableView!
    @IBOutlet weak var uploadImage: UIButton!
    @IBOutlet weak var uploadedImg: UIImageView!
    @IBOutlet weak var addDescriptionLabel: UILabel!
    @IBOutlet weak var addDescriptionTextView: UITextView!
    @IBOutlet weak var addItems: UIButton!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    let hud = JGProgressHUD(style: .light)
    var isTableVisible = false
     var isImageVisible = false
    var itemsToAdd : BagItems?
     var bagId = 0
    //var categoriesResp : [CountriesResp]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text = ConstantStrings.pleaseWait
        tableViewHeight.constant = 0
        imageHeight.constant = 0
        recievers.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "userType")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "userType")
        }
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.text = "ii"
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        self.userType = types[indexPath.row].typeInt!
//        chooseUsersBtn.setTitle("User Selected: \(types[indexPath.row].typeString!)", for: .normal)
        UIView.animate(withDuration: 0.5) {
            self.tableViewHeight.constant = 0
            self.isTableVisible = false
            self.view.layoutIfNeeded()
        }
//        print(self.userType)
        
    }
    
    
    @IBAction func addItemsAction(_ sender: Any) {
        print("Add")
        if let favorites = UserDefaults.standard.array(forKey: "\(self.bagId)") {
            if favorites.count == 0 {
                
                
            } else {
//                var cart: [[String: Any]] = []
//                cart.append(["name": "A", "price": 19.99, "qty": 1])
//
//
//                UserDefaults.standard.removeObject(forKey: "myCart")
//                UserDefaults.standard.set(cart, forKey: "myCart")
//
//                if let loadedCart = UserDefaults.standard.array(forKey: "myCart") as? [[String: Any]] {
//                    print(loadedCart)  // [[price: 19.99, qty: 1, name: A], [price: 4.99, qty: 2, name: B]]"
//                    for item in loadedCart {
//                        print(item["name"]  as! String)    // A, B
//                        print(item["price"] as! Double)    // 19.99, 4.99
//                        print(item["qty"]   as! Int)       // 1, 2
//                    }
//                }
                 let userDefaults = UserDefaults.standard
                var loadedCart = userDefaults.array(forKey: "\(self.bagId)") as? [[String: Any]]
                loadedCart?.append(["name": widthText.text!, "price": 19.99, "qty": 1])
                    userDefaults.removeObject(forKey: "\(self.bagId)")
                    userDefaults.set(loadedCart, forKey: "\(self.bagId)")
               userDefaults.synchronize()
                for item in loadedCart! {
                                            print(item["name"]  as! String)    // A, B
                                            print(item["price"] as! Double)    // 19.99, 4.99
                                            print(item["qty"]   as! Int)       // 1, 2
                                        }
            }
        }else{
            var cart: [[String: Any]] = []
            cart.append(["name": "A", "price": 19.99, "qty": 1])
            
            
            
            UserDefaults.standard.set(cart, forKey: "\(self.bagId)")
        }
       
        //self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func uploadImg(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            if self.isImageVisible == false {
                self.isImageVisible = true
                self.imageHeight.constant = 44.0 * 3.0
            } else {
                self.imageHeight.constant = 0
                self.isImageVisible = false
            }
            self.view.layoutIfNeeded()
        }
        
//
//        let jsonText = "{\"first_name\": [\"Sergey\" , \"Sergey\"] , \"first_name\":\"Sergey\"}"
//        var dictonary:[[String:AnyObject]]?
//
//        if let data = jsonText.data(using: String.Encoding.utf8) {
//
//            do {
//                dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:AnyObject]]
//
//                if let myDictionary = dictonary
//                {
//                    print(myDictionary.count)
//                }
//            } catch let error as NSError {
//                print(error)
//            }
//        }
    }
    
    @IBAction func chooseCategory(_ sender: Any) {
//        let arrayOfDictionaries: [[String:AnyObject]] = [["abc":123 as AnyObject, "def": "ggg" as AnyObject, "xyz": true as AnyObject],["abc":456 as AnyObject, "def": "hhh" as AnyObject, "xyz": false as AnyObject]]
//
//        print(arrayOfDictionaries.toJSONString())
    }
    @IBAction func chooseRecievers(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5) {
            if self.isTableVisible == false {
                self.isTableVisible = true
                self.tableViewHeight.constant = 44.0 * 3.0
            } else {
                self.tableViewHeight.constant = 0
                self.isTableVisible = false
            }
            self.view.layoutIfNeeded()
        }
    }
    
    func getCountries(){
        hud.show(in: self.view)
        GetCountriesCities.GetCountriesCities { (countries, error) in
            self.hud.dismiss()
            if(error == ""){
              //  self.countriesRes = countries
                
            }
        }
        
    }
}
//extension Collection where Iterator.Element == [String:AnyObject] {
//    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
//        if let arr = self as? [[String:AnyObject]],
//            let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
//            let str = String(data: dat, encoding: String.Encoding.utf8) {
//            return str
//        }
//        return "[]"
//    }
//}


