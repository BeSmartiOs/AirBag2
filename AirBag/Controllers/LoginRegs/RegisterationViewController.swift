//
//  RegisterationViewController.swift
//  AirBag
//
//  Created by Geek on 8/15/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit
import JGProgressHUD
//MARK:- Global
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
    //MARK:- OUTETS
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
    
    //MARK:- VARIABLES
    var isTableVisible = false
    let hud = JGProgressHUD(style: .light)
    var countriesRes : [CountriesResp]?
    var categoriesResp : [CategoryResp]?
    var countryDepartureId :Int?
    var phoneCode = ""
    var isHidden = false
    var chooseCats = [Int]()
    var chooseCatsString = [String]()
    
    var frequent_travel_number :Int?
    var  favouriteDeparture_id:Int?
    var  favouriteDestination_id :Int?
    var  addressCity : Int?
    var  address = ""
    var  creditCardInt = ""
    var  regtoken = ""
    var categpryids = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text = ConstantStrings.pleaseWait
        categoryTableViewHeight.constant = 0
        setUpViews()
        categoryTableView.backgroundColor = UIColor.clear
        self.categoryTableView.allowsMultipleSelection = true
        getCategries()
        getCountries()
        regtoken = getRegisterationToken()
        print(regtoken)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
     updateViews()
    }
    //MARK:- IBACTIONS
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
        if(AbstractViewController.validateFeildsRegister(firstName: firstName.text!, lastName: lastName.text!, password: password.text!, confirmPassword: confirmPassword.text!, email: email.text!,phone: self.mobileTextFeild.text!, address: addressTextFeild.text!)){
            
            if(AbstractViewController.isValidPasword(testStr: self.password.text!)){ //valid pass
                
                if(self.password.text! == confirmPassword.text!){ //password match
                   
                    if(AbstractViewController.isValidEmail(testStr: self.email.text!)){
                        
                        if(AbstractViewController.validateNum(number: mobileTextFeild.text!)){
                            print("num yes ")
                            self.errorPass.text = ""
                           // if(chooseCats)
                            
                        
                                if(self.favouriteDeparture_id != nil || self.favouriteDestination_id != nil){
                                    if(self.addressCity != nil){
                                       //   self.creatAlert(tite: "DONE")
                                        
                                        self.registerAccount(firstName: self.firstName.text!, lastName: self.lastName.text!, password: self.password.text!, confirmPass: self.confirmPassword.text!, email: self.email.text!, favDepartureCity: self.favouriteDeparture_id!, favDestinationCity: self.favouriteDestination_id! , addressCityID: self.addressCity!, mobile: self.mobileTextFeild.text!, address: self.addressTextFeild.text!, categories: chooseCats, creditCard: self.creditCard.text!, numOfTravels: self.numberOfTravel.text!, registerationToken: self.regtoken)
                                        
                                        
                                        
                                        
                                    }else{
                                              self.creatAlert(tite: ConstantStrings.fillRequiredAddress)
                                    }
                                   
                                }else{
                                    self.creatAlert(tite: ConstantStrings.fillRequiredAddress)
                                }
                           
                            /*if()frequent_travel_number (int),
                        
                             */
                            
                             print("woohoo")
                        }else{
                             print("not nums ")
                              self.creatAlert(tite: ConstantStrings.wrongNum)
                        }
                        
                    }else{
                        print("email wrong ")
                          self.creatAlert(tite: ConstantStrings.emailVAid)
                    }
                }else{
                     print("pass doesnt match")
                     self.creatAlert(tite: ConstantStrings.psddwordDoesntMAtch)
                    self.errorPass.text = ConstantStrings.psddwordDoesntMAtch
                   //pass doesnt match
                }
                
            }else{
                 print("wromg pass")
                  self.errorPass.text = ConstantStrings.passwordWrong
                  self.creatAlert(tite: ConstantStrings.passwordWrong)
                //wromg pass
            }
            
        }else{
            self.creatAlert(tite: ConstantStrings.pleaseFillRequired)
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
    //MARK:- TABLEVIEW
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
    
        //MARK:- CALLBACK Func
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
         self.firstName.placeholder = ConstantStrings.firstName
         self.lastName.placeholder = ConstantStrings.lastName
         self.email.placeholder = ConstantStrings.emailLabelPlace
         self.password.placeholder = ConstantStrings.passwordLabel
         self.confirmPassword.placeholder = ConstantStrings.confirmPAss
         self.creditCard.placeholder = ConstantStrings.creditCard
         self.numberOfTravel.placeholder = ConstantStrings.numberOfTravels
        self.registerBtn.setTitle(ConstantStrings.register, for: .normal)
        self.departureCountryCity.text = ""
         self.destinationCountryCity.text = ""
         self.choosenAddress.text = ""
        self.mobileCode.text = ConstantStrings.countryCode
        
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
    func updateViews(){ //
        self.passwordExampe.text = ConstantStrings.passwordPlaceHolder
        self.showPassword.setTitle(ConstantStrings.showPassword, for: .normal)
        if(choosenDepartureFinalCity != ""){
            print(choosenDepartureFinalCity)
            print(choosenDepartureFinalCityId)
            print(choosenDepartureFinalCountry)
            self.departureCountryCity.text = choosenDepartureFinalCountry + ", " + choosenDepartureFinalCity ////
            self.favouriteDeparture_id = choosenDepartureFinalCityId
        }
        
        
        if(choosenDestinationFinalCity != ""){

            print(choosenDestinationFinalCountry)
            print(choosenDestinationFinalCity)
            print(choosenDestinationFinalCityId)
            
            
            self.destinationCountryCity.text = choosenDestinationFinalCountry + ", " + choosenDestinationFinalCity
            self.favouriteDestination_id = choosenDestinationFinalCityId
        }
        
        if(choosenAddressFinalCity != ""){
            print(choosenAddressFinalCity)
            print(choosenAddressFinalCityId)
            self.choosenAddress.text = choosenAddressFinalCountry + ", " + choosenAddressFinalCity
            self.addressCity = choosenAddressFinalCityId
        }
        
        if(self.phoneCode != ""){
            self.mobileCode.text = self.phoneCode
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
    
    func creatAlertSucess(tite : String){
        // create the alert
        let alert = UIAlertController(title: tite, message: "", preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler:{ action in
            
          self.navigationController?.popViewController(animated: true)
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func getRegisterationToken() -> String{
       let token =  UserDefaults.standard.string(forKey: "fireBaseTokenUserDefaults")
        if(token != "")
        {
            return token!
        }else{
            return ""
        }
    
    }
    func registerAccount(firstName : String,lastName : String,password : String,confirmPass : String,email : String,favDepartureCity : Int,favDestinationCity : Int,addressCityID : Int,mobile : String,address : String,categories : [Int],creditCard : String,numOfTravels : String,registerationToken : String){
        var travel = 0
        var internalCreditCard = creditCard
        var categoriesInt = categories
        if(AbstractViewController.validateNum(number: numberOfTravel.text!)){
            travel = Int(numOfTravels)!
            }else{
               travel = 0
            }
        if(internalCreditCard == ""){
            internalCreditCard = ""
        }
        if(categoriesInt.count == 0){
            categoriesInt = []
        }
        hud.show(in: self.view)
        RegisterApi.RegisterApi(fcmToken: registerationToken, firstName: firstName, lastName: lastName, email: email, mobile: mobile, addressCityId: addressCityID, address: address, password: password, passwordConfirmation: confirmPass, frequentTravelNumber: travel, favouriteDepartureId: favDepartureCity, favouriteDestinationId: favDestinationCity, creditCard: internalCreditCard, preferredCategories: categoriesInt) { (succss, error) in
            if(error == ""){
                    self.hud.dismiss()
                self.creatAlertSucess(tite:  ConstantStrings.successfulyReg)
            }
        }
        
        
    }
    
}
