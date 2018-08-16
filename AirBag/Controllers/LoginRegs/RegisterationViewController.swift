//
//  RegisterationViewController.swift
//  AirBag
//
//  Created by Geek on 8/15/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit
import JGProgressHUD

var choosenDepartureFinalCity = ""
var choosenDepartureFinalCountry = ""
var choosenDepartureFinalCityId = 0

var choosenDestinationFinalCity = ""
var choosenDestinationFinalCountry = ""
var choosenDestinationFinalCityId = 0

var choosenAddressFinalCity = ""
var choosenAddressFinalCountry = ""
var choosenAddressFinalCityId = 0


class RegisterationViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,classPhoneCode{
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var passwordExampe: UILabel!
    
    @IBOutlet weak var showPassword: UIButton!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var errorPass: UILabel!
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var numberOfTravel: UITextField!
    @IBOutlet weak var creditCard: UITextField!

    @IBOutlet weak var categoryTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var favoriteDepartureCountry: UIButton!
    @IBOutlet weak var departureCountryCity: UILabel!
    @IBOutlet weak var favoriteDestinationCountry: UIButton!
    @IBOutlet weak var destinationCountryCity: UILabel!
    @IBOutlet weak var chooseCategory: UIButton!
    @IBOutlet weak var categoryTableView: UITableView!
    
    @IBOutlet weak var chooseAddress: UILabel!
    @IBOutlet weak var chooseAddressBtn: UIButton!
    @IBOutlet weak var choosenAddress: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var mobileCode: UILabel!
    @IBOutlet weak var mobileTextFeild: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
   
    @IBOutlet weak var addressTextFeild: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    var isTableVisible = false
    let hud = JGProgressHUD(style: .light)
    var countriesRes : [CountriesResp]?
    var categoriesResp : [CategoryResp]?
    var countryDepartureId :Int?
    var phoneCode = ""
    var isHidden = false
    var chooseCats = [Int]()
    var chooseCatsString = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text = ConstantStrings.pleaseWait
        categoryTableViewHeight.constant = 0
        setUpViews()
        categoryTableView.backgroundColor = UIColor.clear
        self.categoryTableView.allowsMultipleSelection = true
        getCategries()
        getCountries()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
     updateViews()
    }

    @IBAction func favoriteDepartureCountry(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChooseCountriesViewController") as! ChooseCountriesViewController
        popOverVC.countriesRes = self.countriesRes
        self.navigationController?.present(popOverVC, animated: true, completion: nil)
    }
    
    @IBAction func favoriteDestinationCountry(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChooseDestinationCountryViewController") as! ChooseDestinationCountryViewController
        popOverVC.countriesRes = self.countriesRes
        self.navigationController?.present(popOverVC, animated: true, completion: nil)
    }
    
    @IBAction func chooseCategory(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5) {
            if self.isTableVisible == false {
                self.isTableVisible = true
                self.categoryTableViewHeight.constant = 44.0 * 3.0
            } else {
                self.categoryTableViewHeight.constant = 0
                self.isTableVisible = false
            }
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func chooseAddressAction(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChooseAddressCountriesViewController") as! ChooseAddressCountriesViewController
        popOverVC.countriesRes = self.countriesRes
        popOverVC.delegatePhone = self
        self.navigationController?.present(popOverVC, animated: true, completion: nil)
    }
    
    
    
  
    @IBAction func registerBtnAction(_ sender: Any) {
        if(AbstractViewController.validateFeildsRegister(firstName: firstName.text!, lastName: lastName.text!, password: password.text!, confirmPassword: confirmPassword.text!, email: email.text!,phone: self.mobileTextFeild.text!)){
            
            if(AbstractViewController.isValidPasword(testStr: self.password.text!)){ //valid pass
                
                if(self.password.text! == confirmPassword.text!){ //password match
                   
                    if(AbstractViewController.isValidEmail(testStr: self.email.text!)){
                        
                        if(AbstractViewController.validateNum(number: mobileTextFeild.text!)){
                            print("num yes ")
                            self.errorPass.text = ""
                           // if()
                            /*if()frequent_travel_number (int),
                             favourite_departure_id(int)(city_id) ,
                             favourite_destination_id (int)(city_id),
                             credit_card(string) ,address,address city id,regtoken,categpryids*/
                            
                             print("woohoo")
                        }else{
                             print("not nums ")
                        }
                        
                        
                        
                    }else{
                        print("email wrong ")
                    }
                }else{
                     print("pass doesnt match")
                    self.errorPass.text = ConstantStrings.psddwordDoesntMAtch
                   //pass doesnt match
                }
                
            }else{
                 print("wromg pass")
                  self.errorPass.text = ConstantStrings.passwordWrong
                //wromg pass
            }
            
        }else{
            
        }
    }
    
    
    @IBAction func showPassword(_ sender: Any) {
        
        if(isHidden == false){
        password.isSecureTextEntry = true
            isHidden  = true
        }else{
            password.isSecureTextEntry = false
             isHidden  = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.categoriesResp != nil){
            return (self.categoriesResp?.count)!
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "category")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "category")
        }
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.text = self.categoriesResp?[indexPath.row].name
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
                chooseCategory.setTitle("Category Selected: \(choosenFinal)", for: .normal)
            }else{
                let choosenFinal  = choosen.joined(separator: ",")
                chooseCategory.setTitle("Category Selected: \(choosenFinal)", for: .normal)
            }
            
           
            UIView.animate(withDuration: 0.5) {
                self.categoryTableViewHeight.constant = 0
                self.isTableVisible = false
                self.view.layoutIfNeeded()
            }
            self.categoryTableView.reloadData()
            
        }else{
            recievers?.isSelected = true
            self.chooseCats.append((recievers?.id)!)
             self.chooseCatsString.append((recievers?.name)!)
            let choosen = self.chooseCatsString
            if(choosen.count < 1 || choosen.count == 1 ){
                let choosenFinal  = choosen.joined(separator: " ")
                chooseCategory.setTitle("Category Selected: \(choosenFinal)", for: .normal)
            }else{
                let choosenFinal  = choosen.joined(separator: ",")
                chooseCategory.setTitle("Category Selected: \(choosenFinal)", for: .normal)
            }
            UIView.animate(withDuration: 0.5) {
                self.categoryTableViewHeight.constant = 0
                self.isTableVisible = false
                self.view.layoutIfNeeded()
            }
          self.categoryTableView.reloadData()
        }
       
        
    }
    
    
    func setUpViews(){
        self.errorPass.text = ""
        self.errorEmail.text = ""
        self.favoriteDepartureCountry.setTitle(ConstantStrings.deparCountry, for: .normal)
        self.favoriteDestinationCountry.setTitle(ConstantStrings.destCountry, for: .normal)
         self.chooseAddressBtn.setTitle(ConstantStrings.chooseAddress, for: .normal)
        self.chooseAddress.text = ConstantStrings.chooseAddress
        self.mobileLabel.text = ConstantStrings.mobile
         self.addressLabel.text = ConstantStrings.chooseAddress
        self.addressTextFeild.placeholder = ConstantStrings.typeAddress
        self.mobileTextFeild.placeholder = ConstantStrings.typePhone
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
    func getCategries(){
        hud.show(in: self.view)
        GetCategories.GetCategories{(categories, error) in
            self.hud.dismiss()
            if(error == ""){
                self.categoriesResp = categories
                self.categoryTableView.reloadData()
            }
        }
        
    }
    func ChoosePhoneCode(_ phoneCode: String?) {
        self.phoneCode = phoneCode!
    }
    func updateViews(){
        self.passwordExampe.text = ConstantStrings.passwordPlaceHolder
        self.showPassword.setTitle(ConstantStrings.showPassword, for: .normal)
        if(choosenDepartureFinalCity != ""){
            print(choosenDepartureFinalCity)
            print(choosenDestinationFinalCityId)
            self.departureCountryCity.text = choosenDepartureFinalCountry + ", " + choosenDepartureFinalCity ////
        }
        
        
        if(choosenDestinationFinalCity != ""){
            print(choosenDestinationFinalCity)
            print(choosenDestinationFinalCityId)
            self.destinationCountryCity.text = choosenDestinationFinalCountry + ", " + choosenDestinationFinalCity
        }
        
        if(choosenAddressFinalCity != ""){
            print(choosenAddressFinalCity)
            print(choosenAddressFinalCityId)
            self.choosenAddress.text = choosenAddressFinalCountry + ", " + choosenAddressFinalCity
        }
        
        if(self.phoneCode != ""){
            self.mobileCode.text = self.phoneCode
        }
    }
}
