//
//  BagDetailsViewController.swift
//  AirBag
//
//  Created by Geek on 8/20/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit
import JGProgressHUD

class BagDetailsViewController: UIViewController {

    @IBOutlet weak var numberOfSeens: UILabel!
    @IBOutlet weak var departureDestinationView: UIView!
     @IBOutlet weak var departureLabelText: UILabel!
    @IBOutlet weak var departureLabel: UILabel!
    
    @IBOutlet weak var destinationLabelText: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    
    
    @IBOutlet weak var dayeTimeView: UIView!
    
    @IBOutlet weak var dateLabelText: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabelText: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    @IBOutlet weak var availableWeightView: UIView!
    
    @IBOutlet weak var weightLabelText: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var priceKGLabelText: UILabel!
    @IBOutlet weak var  priceKGLabel: UILabel!
    
    @IBOutlet weak var  priceM3LabelText: UILabel!
    @IBOutlet weak var priceM3Label: UILabel!
    
    @IBOutlet weak var flightNumberView: UIView!
    
    @IBOutlet weak var flightNumLabelText: UILabel!
    @IBOutlet weak var flightNumLabel: UILabel!
    
    @IBOutlet weak var airLineLabelText: UILabel!
    @IBOutlet weak var  airLineKGLabel: UILabel!
    
    @IBOutlet weak var  departureMobLabelText: UILabel!
    @IBOutlet weak var departureMobLabel: UILabel!
    
     @IBOutlet weak var restirectedCategoriesLabelText: UILabel!
    @IBOutlet weak var restirectedCategories: UILabel!
    
    @IBOutlet weak var bookBage: UIButton!
    
    var bagId = 0
    let hud = JGProgressHUD(style: .light)
    var currentBag : BagDetialsResp?
    override func viewDidLoad() {
        super.viewDidLoad()
        customeCenterImage()
          hud.textLabel.text = ConstantStrings.pleaseWait
        setUpViews()
      self.getBagDetails(bagId:  self.bagId)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    @IBAction func bookBagAction(_ sender: Any) {
        print("ffff")
        performSegue(withIdentifier: "goToReserveBag", sender: self)
    }
    
    func setUpViews(){
        self.departureLabelText.text = ConstantStrings.departureText
        self.destinationLabelText.text = ConstantStrings.DestinationText
        self.dateLabelText.text = ConstantStrings.dateText
        self.timeLabelText.text = ConstantStrings.timeText
        self.weightLabelText.text = ConstantStrings.availableWeightText
        self.priceKGLabelText.text = ConstantStrings.pricePerKg
        self.priceM3LabelText.text = ConstantStrings.pricePerM3
        self.flightNumLabelText.text = ConstantStrings.flightNumber
        self.airLineLabelText.text = ConstantStrings.airLine
        self.departureMobLabelText.text = ConstantStrings.departureMob
        self.bookBage.setTitle(ConstantStrings.bookBag, for: .normal)
        self.restirectedCategoriesLabelText.text = ConstantStrings.restrictedCategories
        
    }
    

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
        if(segue.identifier == "goToReserveBag"){
            let destination = segue.destination as! ReserveBagViewController
            destination.bagId = self.bagId
            destination.currentBag  = self.currentBag
        }
     }
    func getBagDetails(bagId : Int){
        hud.show(in: self.view)
        BagDetails.GetBagDetails(bagId: bagId) { (bagDetailsResp, error) in
            self.hud.dismiss()
            if(bagDetailsResp?.bagInfo?.count != 0){
                self.currentBag = bagDetailsResp
                for bagInfo in (bagDetailsResp?.bagInfo)!{
                    let view = bagInfo.views
                    let viewFinal = String(describing: view!)
                    self.numberOfSeens.text = viewFinal + " seen"
                    self.departureLabel.text = bagInfo.departureName
                     self.destinationLabel.text = bagInfo.destinationName
                    let dateTime = bagInfo.departureDatetime?.components(separatedBy: " ")
                    
                    self.dateLabel.text   = dateTime?[0]
                    self.timeLabel.text   = dateTime?[1]
                
                    
                    let price = bagInfo.kgPrice
                    let priceFinal = String(describing: price!)
                    self.priceKGLabel.text = "$" + priceFinal
                    
                    
                    let priceM3 = bagInfo.kgPrice
                    let priceFinalM3 = String(describing: priceM3!)
                    self.priceM3Label.text = "$" + priceFinalM3
                    
                    let weight = bagInfo.availableWeight
                    let weightFinal = String(describing: weight!)
                    self.weightLabel.text = weightFinal
                    
                    
                    
                    self.flightNumLabel.text = bagInfo.flightNumber
      
                    self.airLineKGLabel.text = bagInfo.airlineName
                    
                     self.departureMobLabel.text = bagInfo.departureMobile
                }
                
                var arr = [String]()
                for bagDetailss in (bagDetailsResp?.bagRestrictions)!{
                    arr.append(bagDetailss.name!)
                    
                }
                let categoryRest  = arr.joined(separator: ",")
                self.restirectedCategories.text = categoryRest
            }
            
        }
    }
    
}
