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
        override func viewDidLoad() {
            super.viewDidLoad()
            customeCenterImage()
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
    
    
        /*
        // MARK: - Navigation
    
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
        }
        */
    
        func getBag(){
            hud.show(in: self.view)
            CretaeBag.GetCarrierBags { (bagResp, error) in
                self.hud.dismiss()
                if(error == ""){
                    self.bagResp = bagResp
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
                        
                            self.bagAvialFrom.text = info.notAvailableFrom
                            self.bagAvialTo.text = info.notAvailableTo
                            self.bagId = info.id!
                        
                            if(self.bagId == 0){
                            self.sealBagBtn.isEnabled = false
                            }else{
                            self.sealBagBtn.isEnabled = true
                                    }
//                        let imagess = info.ticketScan!
//                        let data = Data(imagess.utf8)
//                        let dataDecode:NSData = NSData(base64Encoded: data, options:.ignoreUnknownCharacters)!
//                        let avatarImage:UIImage = UIImage(data: dataDecode as Data)!
                       // print(avatarImage.)
            }
                    
                    
                    for cats in (self.bagResp?.bagRestrictions)!{
                          self.newCategoriesData.text = cats.name
                    }
                }
    }

}
    @IBAction func sealBag(_ sender: Any) {
        if(self.bagId == 0){
            
        }else{
            
            CretaeBag.sealBag(bagId: self.bagId) { (bag, error) in
                if(error == ""){
                    
                }
            }
        }
    }
    func convertBase64ToImage(base64String: String) -> UIImage {
        
        let decodedData = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0) )
        
        let decodedimage = UIImage(data: decodedData! as Data)
        
        return decodedimage!
        
    }
}
