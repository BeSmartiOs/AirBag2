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
var choosenCategoryNameGlobal = ""
var choosenCategoryId = 0
var choosenItemNameGlobal = ""
var choosenItemIdGlobal = 0


class AddItemsInBagViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {

    @IBOutlet weak var itemName: UITextField!
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
    @IBOutlet weak var itemCatName: UILabel!
    
    let hud = JGProgressHUD(style: .light)
    var isTableVisible = false
    var isImageVisible = false
    var itemsToAdd : BagItems?
    var bagId = 0
    var weight : Double?
    var height : Double?
    var width : Double?
    var length : Double?
    var imageString : String?
    var descriptionString : String?
    var recieverId = 0
    var recieverName = ""
    var itemId = 0
    var categoryName : String?
    var itemNameString : String?
    var recieversUsers : [UsersResp]?
    var currentBag : BagDetialsResp?
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text = ConstantStrings.pleaseWait
        tableViewHeight.constant = 0
        recievers.backgroundColor = UIColor.clear
        getRecievers()
        if let favorites = UserDefaults.standard.array(forKey: "\(self.bagId)") {
            if favorites.count == 0 {
                self.choosenReciever.isEnabled = true
                
            } else {
                self.choosenReciever.isEnabled = false
                let userDefaults = UserDefaults.standard
                let loadedCart = userDefaults.array(forKey: "\(self.bagId)") as? [[String: Any]]
                for items in loadedCart!{
                    self.recieverId = items["recieverId"] as! Int
                    self.recieverName = items["recieverName"] as! String
                }
                
            }
        }else{
            self.choosenReciever.isEnabled = true
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = false
    update()
    }
    func update(){
        self.itemCatName.text = ""
        if(choosenItemIdGlobal != 0){
            self.itemCatName.text = choosenCategoryNameGlobal + " , " + choosenItemNameGlobal
            self.itemId = choosenItemIdGlobal
            print(choosenCategoryNameGlobal)
            print(choosenItemNameGlobal)
        }else{
            
               self.itemCatName.text = ""
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.recieversUsers != nil ){
            return (self.recieversUsers?.count)!
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "userType")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "userType")
        }
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.text = self.recieversUsers?[indexPath.row].nickname
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.recieverId = (self.recieversUsers?[indexPath.row].id)!
        self.recieverName = (self.recieversUsers?[indexPath.row].nickname)!
        choosenReciever.setTitle("User Selected: \(self.recieverName)", for: .normal)
        UIView.animate(withDuration: 0.5) {
            self.tableViewHeight.constant = 0
            self.isTableVisible = false
            self.view.layoutIfNeeded()
        }
        print( self.recieverId)
        
    }
    
    
    @IBAction func addItemsAction(_ sender: Any) {
        print("Add")
        
        if(self.recieverId == 0 || self.widthText.text == "" || self.heightText.text == "" || self.weightText.text == "" || self.lengthText.text == "" || self.itemId == 0 || self.itemName.text == "" ){
            self.creatAlert(tite: ConstantStrings.pleaseFillRequired)
        }else{
           
            if(AbstractViewController.validateNum(number: self.heightText.text!)){
                print("num yes ")
                self.itemNameString = self.itemName.text
                self.height = Double(self.heightText.text ?? "") ?? 0.0
                self.weight = Double(self.weightText.text ?? "") ?? 0.0
                self.width = Double(self.widthText.text ?? "") ?? 0.0
                self.length = Double(self.lengthText.text ?? "") ?? 0.0
                    if(self.uploadedImg.image != nil ){
                        let imageData = UIImageJPEGRepresentation(self.uploadedImg.image!, 0.4)
                        let base64String = imageData?.base64EncodedString(options: .lineLength64Characters)
                        self.imageString = base64String!
                        print(base64String ?? "")
                    }else{
                        self.imageString = ""
                    }
                    if(self.addDescriptionTextView.text == "" ){
                   self.descriptionString = ""
                    }else{
                         self.descriptionString = self.addDescriptionTextView.text
                        
                }
                
                self.addToDefaults(width: self.width!, height: self.height!, weight: self.weight!, length: self.length!, recId: self.recieverId, itemId: self.itemId, image: self.imageString!, descrip: self.descriptionString!, itemName: self.itemNameString!, recName: self.recieverName)
                
                
            }else{
                self.creatAlert(tite: "Please enter valid Weight/Height/Width/Length")
            }  
        }
    
    }
    func addToDefaults(width: Double , height: Double,weight: Double,length: Double,recId: Int,itemId : Int, image: String,descrip: String,itemName : String, recName : String){
        print(self.bagId)
        
                if let favorites = UserDefaults.standard.array(forKey: "\(self.bagId)") {
                    if favorites.count == 0 {
        
        
                    } else {

                         let userDefaults = UserDefaults.standard
                        var loadedCart = userDefaults.array(forKey: "\(self.bagId)") as? [[String: Any]]
                        loadedCart?.append(["width": width, "height": height, "weight": weight, "length" : length, "recieverId" : recId, "itemId" : choosenItemIdGlobal, "image" : image , "description" : descrip, "itemName" : itemName, "recieverName" : recName])
                            userDefaults.removeObject(forKey: "\(self.bagId)")
                            userDefaults.set(loadedCart, forKey: "\(self.bagId)")
                            userDefaults.synchronize()
                        for item in loadedCart! {
                            print(item["width"]  as! Double)    // A, B
                            print(item["height"] as! Double)    // 19.99, 4.99
                            print(item["weight"]  as! Double)    // A, B
                            print(item["length"] as! Double)       // 1, 2
                             print(item["itemName"] as! String)
                                                }
                    }
                }else{
                    var cart: [[String: Any]] = []
                    cart.append(["width": width, "height": height, "weight": weight, "length" : length, "recieverId" : recId, "itemId" : choosenItemIdGlobal, "image" : image , "description" : descrip, "itemName" : itemName, "recieverName" : recName])
        
        
        
                    UserDefaults.standard.set(cart, forKey: "\(self.bagId)")
                }
         choosenCategoryNameGlobal = ""
         choosenCategoryId = 0
         choosenItemNameGlobal = ""
         choosenItemIdGlobal = 0
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func uploadImg(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //After it is complete
        }
        
        

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            uploadedImg.image = image
          
        }
        else
        {
            //Error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func chooseCategory(_ sender: Any) {
     performSegue(withIdentifier: "goToCats", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToCats"){
            let des = segue.destination as! ChooseCategoryViewController
            des.bagId = self.bagId
            
        }
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
    
    func getRecievers(){
        GetRecievers.GetRecievers { ( users, error) in
            if(error == ""){
                
                self.recieversUsers = users
                self.recievers.reloadData()
            }
        }
        
    }
    func creatAlert(tite : String){
        // create the alert
        let alert = UIAlertController(title: tite, message: "", preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
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

