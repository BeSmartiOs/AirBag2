//
//  FilterViewController.swift
//  AirBag
//
//  Created by Geek on 8/28/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit
import JGProgressHUD

var airLineId = 0
var airLineName = ""

var carrierId = 0
var carrierName = ""



var DeparCuntryName = ""
var DestCuntryName = ""


var DeparCityName = ""
var DestCityName = ""



var DeparCityId = 0
var DestCityId = 0

class FilterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,classAirLine,classCarrier {
    
   
    
    
    
    @IBOutlet weak var DestinationCity: UILabel!
    @IBOutlet weak var departureCity: UILabel!
    @IBOutlet weak var fightText: UITextField!
    @IBOutlet weak var carrierNameLabel: UILabel!
    @IBOutlet weak var chooseCategory: UIButton!
    @IBOutlet weak var airlines: UILabel!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    let hud  = JGProgressHUD(style: .light)
    var typeOfWay : Int?
    var type : Int?
    var isTableVisible = false
    var categoriesResp : [CategoryResp]?
     var categoryId = 0
    var countriesRes : [CountriesResp]?
    var itemsA : [AvailableFeaturedBag]?
    var itemsB : [AvailableNormalBag]?
    var bagsResp : BagsResponse?
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text = ConstantStrings.pleaseWait
        self.tableHeight.constant = 0
        getCategries()
        getCountries()
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        if(airLineId == 0){
            self.airlines.text = ""
        }else{
              self.airlines.text = airLineName
            
        }
        
        
        if(carrierId == 0){
            self.carrierNameLabel.text = ""
        }else{
            self.carrierNameLabel.text = carrierName
            
        }
       
        if(DeparCuntryName == ""){
              self.departureCity.text  = ""
        }else{
            print(DeparCuntryName)
             print(DeparCityId)
             print(DeparCityName)
            self.departureCity.text  = DeparCuntryName + ", " + DeparCityName

        }
        if(DestCuntryName == ""){
          self.DestinationCity.text  = ""
        }else{
            print(DestCuntryName)
            print(DestCityId)
            print(DestCityName)
             self.DestinationCity.text  = DestCuntryName + ", " + DestCityName
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.categoriesResp != nil){
            return (self.categoriesResp?.count)!
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
        cell?.textLabel?.text = self.categoriesResp![indexPath.row].name
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.categoryId = self.categoriesResp![indexPath.row].id!
        chooseCategory.setTitle("Category Selected: \(self.categoriesResp![indexPath.row].name!)", for: .normal)
        UIView.animate(withDuration: 0.5) {
            self.tableHeight.constant = 0
            self.isTableVisible = false
            self.view.layoutIfNeeded()
        }
      
        
    }


    @IBAction func choseAirLine(_ sender: Any) {
        self.type = 1
       performSegue(withIdentifier: "goToAirlines", sender: self)
    }
    
    
    @IBAction func choseCarrier(_ sender: Any) {
          self.type = 2
               performSegue(withIdentifier: "goToAirlines", sender: self)
    }
    @IBAction func choseDeparture(_ sender: Any) {
        self.typeOfWay = 3
        
        performSegue(withIdentifier: "goToCountryFiltered", sender: self)
    }
    @IBAction func choseDestination(_ sender: Any) {
         self.typeOfWay = 4
        performSegue(withIdentifier: "goToCountryFiltered", sender: self)
    }
    @IBAction func choseCategory(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            if self.isTableVisible == false {
                self.isTableVisible = true
                self.tableHeight.constant = 44.0 * 3.0
            } else {
                self.tableHeight.constant = 0
                self.isTableVisible = false
            }
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func Filter(_ sender: Any) {
        if( DeparCityId == 0 || DestCityId == 0 || carrierId == 0){
            //please fill required
            self.creatAlert(tite: ConstantStrings.pleaseFillRequired)
        }else{
            if(fightText.text == "" || fightText.text?.isEmpty == true || airLineId == 0 ){
                self.creatAlert(tite: ConstantStrings.pleaseFillRequired)
            }else{
                getFilteredBags()
            }
        }
       
    }
    @IBAction func Reset(_ sender: Any) {
        
         airLineId = 0
         airLineName = ""
         carrierId = 0
         carrierName = ""
         DeparCuntryName = ""
         DestCuntryName = ""
         DeparCityName = ""
         DestCityName = ""
         DeparCityId = 0
         DestCityId = 0
        self.airlines.text = ""
        self.carrierNameLabel.text = ""
        self.DestinationCity.text = ""
        self.departureCity.text = ""
        self.chooseCategory.setTitle("Choose Categories: ", for: .normal)
        self.categoryId = 0
    }
    
    func classAirLines(_ airine: String?, _ id: Int?) {
        airLineId = id!
        airLineName = airine!
    }
    func classCarriers(_ name: String?, _ id: Int?) {
        carrierId = id!
        carrierName = name!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "goToAirlines"){
            let des = segue.destination as! ChooseAirLineViewController
            des.airLines = self
            des.carriers = self
            des.type = self.type
        }else if (segue.identifier == "goToCountryFiltered") {
            let des = segue.destination as! DeparDestCountryViewController
            des.countriesRes = self.countriesRes
            des.typeOfWay = self.typeOfWay
        }else{
            let des = segue.destination as! AvailableBagFromFilterViewController
           des.itemsA = self.itemsA
            des.itemsB = self.itemsB
            des.bagsResp = self.bagsResp
        }
            
    }
    
    func getCategries(){
        
        GetCategories.GetCategories{(categories, error) in
            
            if(error == ""){
                self.categoriesResp = categories
                self.tableView.reloadData()
            }
        }
        
    }
    
    func getCountries(){
        hud.show(in: self.view)
        GetCountriesCities.GetCountriesCities { (countries, error) in
            self.hud.dismiss()
            if(error == ""){
                self.countriesRes = countries
            }
        }
        
    }
    
    func getFilteredBags(){
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginContentt
        self.hud.dismiss()
        GetAvailableBags.GetAvailableBags(departureId: DeparCityId, destinationId: DestCityId, carrierId: carrierId, categoryId: self.categoryId, airlineId: airLineId, flightNumber: fightText.text! , aceessToken: decodedUser.token!, type: 1) { (bags, error) in
            
                            if(error == ""){
                                self.hud.dismiss()
                                self.bagsResp = bags
                                if(bags?.availableFeaturedBags?.count != 0){
                                    self.itemsA = bags?.availableFeaturedBags
                                    self.itemsB = bags?.availableNormalBags
                                }
                                
                        self.performSegue(withIdentifier: "filteredBags", sender: self)
                            }else{
                                self.hud.dismiss()
            }
            self.hud.dismiss()

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
