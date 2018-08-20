//
//  BagDetailsViewController.swift
//  AirBag
//
//  Created by Geek on 8/20/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit

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
            
        }
     }
    
    
}
