//
//  CurrentBagViewController.swift
//  AirBag
//
//  Created by Geek on 8/30/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit
import JGProgressHUD

class CurrentBagViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var availableWeight: UILabel!
    @IBOutlet weak var availableWeightData: UILabel!
    @IBOutlet weak var kgPrice: UILabel!
    @IBOutlet weak var kgPriceData: UILabel!
    @IBOutlet weak var M3Price: UILabel!
    @IBOutlet weak var M3PriceData: UILabel!
    
    @IBOutlet weak var noDataLabel: UILabel!
    
    @IBOutlet weak var destinationAir: UILabel!
    @IBOutlet weak var destinationAirData: UILabel!
    @IBOutlet weak var departureAir: UILabel!
    @IBOutlet weak var departureAirData: UILabel!
    
    @IBOutlet weak var deartureMob: UILabel!
    @IBOutlet weak var deartureMobData: UILabel!
    @IBOutlet weak var destinationMob: UILabel!
    @IBOutlet weak var destinationMobData: UILabel!
    @IBOutlet weak var featuredTill: UILabel!
    @IBOutlet weak var featuredTillData: UILabel!
    @IBOutlet weak var flightNumber: UILabel!
    @IBOutlet weak var flightNumberData: UILabel!
    
    
    @IBOutlet weak var departureTime: UILabel!
    @IBOutlet weak var departureTimeData: UILabel!
    @IBOutlet weak var newCategories: UILabel!
    @IBOutlet weak var newCategoriesData: UILabel!
    @IBOutlet weak var airLineLabel: UILabel!
    @IBOutlet weak var airLineLabelData: UILabel!
    @IBOutlet weak var bagAvialability: UILabel!
    @IBOutlet weak var bagAvialFrom: UILabel!
    @IBOutlet weak var bagAvialTo: UILabel!
    @IBOutlet weak var ticketScan: UIImageView!
    @IBOutlet weak var ticketScanData: UILabel!
    
    @IBOutlet weak var sealBagBtn: UIButton!
    
    
    
        let userDefaults = UserDefaults.standard
        let hud = JGProgressHUD(style: .light)
        var bagResp : BagDetialsResp?
        var bagId = 0
        var typeOfBtn : Int?
    
        override func viewDidLoad() {
            super.viewDidLoad()
            customeCenterImage()
            self.clearData()
            hud.textLabel.text = ConstantStrings.pleaseWait
            // Do any additional setup after loading the view.
        }
    override func viewWillAppear(_ animated: Bool) {
         getBag()
    }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

        func getBag(){
            hud.show(in: self.view)
            CretaeBag.GetCarrierBags { (bagResp, error) in
                self.hud.dismiss()
                print(error)
                self.bagResp = bagResp
                if(error == ""){
                    if(bagResp?.bagInfo?.count != 0){
                    
                    self.setData()
                         self.noDataLabel.text = ""
                    for info in  (self.bagResp?.bagInfo)!{
                    let weight = info.availableWeight!
                        self.availableWeightData.text = "\(weight)"
                        let kgPrice = info.kgPrice!
                            self.kgPriceData.text = "\(kgPrice)"
                      let m3Price = info.m3Price!
                            self.M3PriceData.text = "\(m3Price)"
                            self.destinationAirData.text =  info.destinationName
                            self.departureAirData.text = info.departureName
                            self.deartureMobData.text = info.departureMobile
                        self.destinationMobData.text = info.destinationMobile as? String
                        
                        if(info.featured == 1){
                             self.featuredTillData.text = "Not a featured flight!"
                        }else{
                            self.featuredTillData.text = "Featured flight!" + " " + info.featuredTill!
                            
                        }
                            self.flightNumberData.text = info.flightNumber
                            self.departureTimeData.text = info.departureDatetime
                            self.airLineLabelData.text = info.airlineName
                        self.bagAvialFrom.text = "From: " + info.notAvailableFrom!
                        self.bagAvialTo.text = "To: " + info.notAvailableTo!
                            self.bagId = info.id!
                            if(self.bagId == 0){
                            self.sealBagBtn.isEnabled = false
                            }else{
                            self.sealBagBtn.isEnabled = true
                                    }
                        // Get the String from UserDefaults
                        if let myString = self.userDefaults.string(forKey: "ticketScanString") {
                              self.ticketScan.image = AbstractViewController.convertBase64ToImage(imageString: myString)
                            
                        }
                  
            }
                    
                        var catsString = [""]
                    for cats in (self.bagResp?.bagRestrictions)!{
                        catsString.append(cats.name!)
                        
                    }
                       let joined = catsString.joined(separator: " ")
                          self.newCategoriesData.text = joined
                    }else{
                        self.noDataLabel.text = "No bag created yet!"
                        self.clearData()
                    }
                }else if (error == Constants.UserType.tokenExpired){
                   self.bagResp = bagResp
                    self.createAlert(title: ConstantStrings.sessionExpired)
                }else{
                    self.bagResp = bagResp
                     self.clearData()
                     self.noDataLabel.text = "No bag created yet!"
                }
            }
}

    
  
    @IBAction func sealBag(_ sender: Any) {
        if(self.bagId == 0){
            
        }else{
            self.createAlert(title:ConstantStrings.sealBagConfirm)
         
        }
    }
    @IBAction func editBag(_ sender: Any) {
        if(self.bagResp?.bagInfo?.count == 0){
       
        }else{
            //self.typeOfBtn = 1
            performSegue(withIdentifier: "goToEdit", sender: self)
            
        }
        
        
        
        
    }
//    func convertBase64ToImage(base64String: String) -> UIImage {
//
//        let decodedData = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0) )
//
//        let decodedimage = UIImage(data: decodedData! as Data)
//
//        return decodedimage!
//
//    }
    
//      func getImageFromBase64(base64:String) -> UIImage {
//        let data = Data(base64Encoded: base64, options: Data.Base64DecodingOptions.init(rawValue: 0))
//        return UIImage(data: data!)!
//    }
    
    func createAlert(title : String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        if(title == ConstantStrings.sealBagConfirm){
            alert.addAction(UIAlertAction(title: ConstantStrings.yes, style: UIAlertActionStyle.default, handler: { (action) in
                self.sealBAg()
            }))
        }else if(title == ConstantStrings.bagSealedSuccess){
            alert.addAction(UIAlertAction(title: ConstantStrings.yes, style: UIAlertActionStyle.default, handler: { (action) in
              self.getBag()
            }))
        }else if(title == ConstantStrings.sessionExpired){
            alert.addAction(UIAlertAction(title: ConstantStrings.yes, style: UIAlertActionStyle.default, handler: { (action) in
               self.logOutFromApp()
            }))
        }else if(title ==  ConstantStrings.pleaseSeal){
            alert.addAction(UIAlertAction(title: ConstantStrings.yes, style: UIAlertActionStyle.default, handler: { (action) in
               
            }))
        }
       
        alert.addAction(UIAlertAction(title:ConstantStrings.no , style: UIAlertActionStyle.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
   
    
    
    func sealBAg(){
        hud.show(in: self.view)
        CretaeBag.sealBag(bagId: self.bagId) { (bag, error) in
            if(error == ""){
                self.hud.dismiss()
                self.userDefaults.removeObject(forKey: "ticketScanString")
                self.ticketScan.image = nil
                self.createAlert(title: ConstantStrings.bagSealedSuccess)
            }else{
                 self.hud.dismiss()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToEdit"){
            let des = segue.destination as! EditBagViewController
            des.bagResp = self.bagResp
            
        }else{
            let des = segue.destination as! CreateBagViewController
           
          
        }
    }
    
    func clearData(){
        self.availableWeight.isHidden = true
        self.availableWeightData.text =  ""
        self.kgPrice.isHidden = true
        self.kgPriceData.text =  ""
        self.M3Price.isHidden = true
        self.M3PriceData.text =  ""
        self.destinationAir.isHidden = true
        self.destinationAirData.text =  ""
        self.departureAir.isHidden = true
        self.departureAirData.text =  ""
        self.deartureMob.isHidden = true
        self.deartureMobData.text =  ""
        self.destinationMob.isHidden = true
        self.destinationMobData.text =  ""
        self.featuredTill.isHidden = true
        self.featuredTillData.text =  ""
        self.flightNumber.isHidden = true
        self.flightNumberData.text =  ""
        self.departureTime.isHidden = true
        self.departureTimeData.text =  ""
        self.newCategories.isHidden = true
        self.newCategoriesData.text =  ""
        self.airLineLabel.isHidden = true
        self.airLineLabelData.text =  ""
        self.bagAvialability.isHidden = true
        self.bagAvialFrom.text =  ""
        self.bagAvialTo.text =  ""
        self.ticketScanData.isHidden = true
    }
    
    func setData(){
        self.availableWeight.isHidden = false

        self.kgPrice.isHidden = false

        self.M3Price.isHidden = false

        self.destinationAir.isHidden = false
       
        self.departureAir.isHidden = false

        self.deartureMob.isHidden = false

        self.destinationMob.isHidden = false

        self.featuredTill.isHidden = false
  
        self.flightNumber.isHidden = false
     
        self.departureTime.isHidden = false
    
        self.newCategories.isHidden = false
  
        self.airLineLabel.isHidden = false

        self.ticketScanData.isHidden = false
        self.bagAvialability.isHidden = false
    }
    
    @IBAction func addBag(_ sender: UIBarButtonItem) {
        if(self.bagResp?.bagInfo == nil){
           // self.typeOfBtn = 2
            performSegue(withIdentifier: "addNewBag", sender: self)
        }else{
                self.createAlert(title:ConstantStrings.pleaseSeal)
        }
    }
    func logOutFromApp(){
        let idForUserDefaults = "logResp"
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: idForUserDefaults)
        userDefaults.removeObject(forKey: "currentUserId")
        userDefaults.removeObject(forKey: "currentUserEmail")
        userDefaults.removeObject(forKey: "currentUserMobile")
        userDefaults.synchronize()
        print(userDefaults.data(forKey: "logResp")?.count ?? 0)
        print(userDefaults.integer(forKey: "currentUserId") )
        print(userDefaults.string(forKey: "currentUserEmail") ?? "")
        print(userDefaults.string(forKey: "currentUserMobile") ?? "")
        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboardMain.instantiateViewController(withIdentifier: "loginView") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = mainViewController
    }
}
