//
//  EditProfilesViewController.swift
//  AirBag
//
//  Created by Geek on 9/10/18.
//  Copyright © 2018 Geek. All rights reserved.
//


var editProfileCityId : Int?
var editProfileCityName : String?
var editProfileCountryCityName : String?



var editProfileDepartureId : Int?
var editProfileDepartureName : String?
var editProfileDepartureCountryName : String?

var editProfileDestinationId : Int?
var editProfileDestinationame : String?
var editProfileDestinationCountryName : String?


import UIKit
import JGProgressHUD
class EditProfilesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 

    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var city: UIButton!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var freqTravel: UITextField!
    @IBOutlet weak var favDeparture:  UIButton!
    @IBOutlet weak var faveDestination:  UIButton!
    @IBOutlet weak var credit: UITextField!
    @IBOutlet weak var preferedCats:  UIButton!
      @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var cityId = 0
    var destinationId = 0
    var departureId = 0
    var chooseCats = [Int]()
    var chooseCatsString = [String]()
    var isTableVisible = false
    var categoriesResp : [CategoryResp]?
    var categoryId = 0
    var countriesRes : [CountriesResp]?
    let hud  = JGProgressHUD(style: .light)
    var typeOfWayEdit : Int?
     var typeOfClass : Int?  //7
    override func viewDidLoad() {
        super.viewDidLoad()
           hud.textLabel.text = ConstantStrings.pleaseWait
        self.tableHeight.constant = 0
        getCategries()
        getCountries()
        customeCenterImage()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(editProfileCityId == nil){
            
        }else{
            cityId = editProfileCityId!
        }
        
        if(editProfileDestinationId == nil){
            
        }else{
            destinationId = editProfileDestinationId!
        }
        if(editProfileDepartureId == nil){
            
        }else{
            departureId = editProfileDepartureId!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func choosereferedCats(_ sender: Any) {
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
    
    
    @IBAction func chooseDeparture(_ sender: Any) {
        self.typeOfWayEdit = 3
        let des = UIStoryboard(name: "Sender", bundle: nil).instantiateViewController(withIdentifier: "DeparDestCountryViewController") as! DeparDestCountryViewController
        des.countriesRes = self.countriesRes
        des.typeOfWay = self.typeOfWayEdit
        des.typeOfClass = self.typeOfClass
        self.navigationController?.pushViewController(des, animated: true)
    }
    
    
    @IBAction func chooseDestination(_ sender: Any) {
        self.typeOfWayEdit = 4
        let des = UIStoryboard(name: "Sender", bundle: nil).instantiateViewController(withIdentifier: "DeparDestCountryViewController") as! DeparDestCountryViewController
        des.countriesRes = self.countriesRes
        des.typeOfWay = self.typeOfWayEdit
        self.navigationController?.pushViewController(des, animated: true)
        
    }
    @IBAction func chooseCity(_ sender: Any) {
        
        self.typeOfWayEdit = 5
        let des = UIStoryboard(name: "Sender", bundle: nil).instantiateViewController(withIdentifier: "DeparDestCountryViewController") as! DeparDestCountryViewController
        des.countriesRes = self.countriesRes
        des.typeOfWay = self.typeOfWayEdit
        self.navigationController?.pushViewController(des, animated: true)
        
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
        
        let recievers = self.categoriesResp?[indexPath.row]
        
        if(recievers?.isSelected == true){
            recievers?.isSelected = false
            if let index = chooseCats.index(of:(recievers?.id)!) {
                chooseCats.remove(at: index)
                
            }
            if let index = chooseCatsString.index(of:(recievers?.name)!) {
                chooseCatsString.remove(at: index)
                
            }
            let choosen = self.chooseCatsString
            if(choosen.count <= 1){
                let choosenFinal  = choosen.joined(separator: " ")
                preferedCats.setTitle("Category Selected: \(choosenFinal)", for: .normal)
            }else{
                let choosenFinal  = choosen.joined(separator: ",")
                preferedCats.setTitle("Category Selected: \(choosenFinal)", for: .normal)
            }
            
            
            UIView.animate(withDuration: 0.5) {
                self.tableHeight.constant = 0
                self.isTableVisible = false
                self.view.layoutIfNeeded()
            }
            self.tableView.reloadData()
            
        }else{
            recievers?.isSelected = true
            self.chooseCats.append((recievers?.id)!)
            self.chooseCatsString.append((recievers?.name)!)
            let choosen = self.chooseCatsString
            if(choosen.count < 1 || choosen.count == 1 ){
                let choosenFinal  = choosen.joined(separator: " ")
                preferedCats.setTitle("Category Selected: \(choosenFinal)", for: .normal)
            }else{
                let choosenFinal  = choosen.joined(separator: ",")
                preferedCats.setTitle("Category Selected: \(choosenFinal)", for: .normal)
            }
            UIView.animate(withDuration: 0.5) {
                self.tableHeight.constant = 0
                self.isTableVisible = false
                self.view.layoutIfNeeded()
            }
            self.tableView.reloadData()
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
    /*
     
 
   
     @IBOutlet weak var city: UIButton!
     @IBOutlet weak var favDeparture:  UIButton!
     @IBOutlet weak var faveDestination:  UIButton!
     var self.cityId == 0
     var destinationId == 0
     var departureId == 0
     
     */
    func checkFeilds(){
        
        if(self.firstName.text == "" || self.lastName.text == "" ||  self.email.text == "" || self.address.text == ""  ||   self.cityId == 0 ||  self.destinationId == 0 ||  self.departureId == 0 ){
            self.creatAlert(tite: ConstantStrings.pleaseFillRequired)
        }else{
            if(AbstractViewController.isValidEmail(testStr: self.email.text!)){
               //  self.editProfile(first_name: self.firstName.text!, last_name: self.lastName.text!, email: self.email.text!, mobile: self.mobile.text!, address_city: self.cityId, frequent_travel_number: Int(self.freqTravel.text!)!, address: self.address.text!, favourite_departure_id: self.departureId, favourite_destination_id: self.destinationId , credit_card: self.credit.text!, preferred_categories:  self.chooseCats)
            }else{
                 self.creatAlert(tite: ConstantStrings.emailVAid)
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
    func editProfile(first_name : String, last_name: String, email: String, mobile: String  ,  address_city : Int , frequent_travel_number: Int,  address: String ,favourite_departure_id: Int, favourite_destination_id: Int, credit_card: String , preferred_categories :[Int]){
        ProfilesApi.EditProfiles(first_name : first_name,last_name : last_name,email : email,mobile: mobile  , address_city : address_city ,frequent_travel_number : frequent_travel_number, address : address ,favourite_departure_id :favourite_departure_id,favourite_destination_id : favourite_destination_id,credit_card  : credit_card , preferred_categories :preferred_categories) { (resp, error) in
            
        }
        
    }
}
