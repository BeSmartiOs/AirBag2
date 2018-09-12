//
//  CreateBagViewController.swift
//  AirBag
//
//  Created by Geek on 8/30/18.
//  Copyright © 2018 Geek. All rights reserved.
//




var bagAirLineId = 0
var bagAirLineName = ""




var bagAirDepartureAiportId = 0
var bagAirDepartureName = ""
var bagAirDepartureCountryName = ""

var bagAirDestinationAiportId = 0
var bagAirDestinationName = ""
var bagAirDestinationCountryName = ""



import UIKit
import JGProgressHUD
class CreateBagViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate,ClassAirLineBag,UITextFieldDelegate,ClassAirPortBag,ClassAirPortBagDes  {
    
    
    
    

    @IBOutlet weak var destinationAir: UILabel!
    @IBOutlet weak var departureAir: UILabel!
    @IBOutlet weak var availableWeight: UITextField!
    @IBOutlet weak var kgWeightPrice: UITextField!
    @IBOutlet weak var m3WeightPrice: UITextField!
    @IBOutlet weak var deartureMob: UITextField!
    @IBOutlet weak var destinationMob: UITextField!
    @IBOutlet weak var flightNumber: UITextField!
    @IBOutlet weak var featureSwitc: UISwitch!
    @IBOutlet weak var featuredTill: UITextField!
    @IBOutlet weak var departureTime: UITextField!
    @IBOutlet weak var addNewCategories: UITextField!
    @IBOutlet weak var bagAvialFrom: UITextField!
    @IBOutlet weak var bagAvialTo: UITextField!
    @IBOutlet weak var chooseCate: UIButton!
    @IBOutlet weak var ticketScan: UIImageView!
    @IBOutlet weak var catItems: UITableView!
    @IBOutlet weak var catItemsHeight: NSLayoutConstraint!
    @IBOutlet weak var airLineLabel: UILabel!
    var bagId = 0
    let hud  = JGProgressHUD(style: .light)
    var isTableVisible = false
    var categoriesResp : [CategoryResp]?
    var countriesRes : [CountriesResp]?
    var chooseCats = [Int]()
    var chooseCatsString = [String]()
    var featured = 0
    var datePicker1 = UIDatePicker()
    var datePicker2 = UIDatePicker()
    var datePicker3 = UIDatePicker()
    var datePicker4 = UIDatePicker()
    var selected : Int?
    var departureDateTime = ""
    var featureDate = ""
    var availableFrom = ""
    var availableTo = ""
    var airPortWay : Int?
    let airPortssViewController = AirPortssViewController()
    var ticketScanString = ""
    var categoriesNew = [String]()
    var available_weight = Double()
    var  kg_price = Double()
    var m3_price = Double()
     var bagResp : BagDetialsResp?
     var typeAddEdit : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        airPortssViewController.delegateDep = self
        airPortssViewController.delegateDes = self
        self.featuredTill.isEnabled = false
       
        getCountries()
        createDatePicker1()
        createDatePicker2()
        createDatePicker3()
        createDatePicker4()
        hud.textLabel.text = ConstantStrings.pleaseWait
        self.catItemsHeight.constant = 0
        self.featuredTill.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
      
       getCategries()
        self.navigationController?.navigationBar.isHidden = false
        //if()
        if(bagAirLineId == 0){
           
                  self.airLineLabel.text = ""
          
            
        }else{
            self.airLineLabel.text = bagAirLineName
            
        }
        if(bagAirDepartureName == ""){
           
                self.departureAir.text = ""
          
        }else{
             self.departureAir.text  = bagAirDepartureName
            print(bagAirDepartureAiportId)
            print(bagAirDepartureName)
            print(bagAirDepartureCountryName)
            
            
        }
        if(bagAirDestinationName == ""){
          
                self.destinationAir.text = ""
           
            
        }else{
               self.destinationAir.text  = bagAirDestinationName
            print(bagAirDestinationAiportId)
            print(bagAirDestinationName)
            print(bagAirDestinationCountryName)
            
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func DeartureAirPort(_ sender: Any) {
        self.airPortWay = 1
        self.typeAddEdit = "addBag"
        performSegue(withIdentifier: "goToDepDesAirport", sender: self)
    }
    
    @IBAction func DestinationAirPort(_ sender: Any) {
        self.airPortWay = 2
        self.typeAddEdit = "addBag"
        performSegue(withIdentifier: "goToDepDesAirport", sender: self)
    }
    
    @IBAction func AirLines(_ sender: Any) {
        self.typeAddEdit = "addBag"
        performSegue(withIdentifier: "goToAirlines", sender: self)
    }
    
    @IBAction func ResytictedCategories(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            if self.isTableVisible == false {
                self.isTableVisible = true
                self.catItemsHeight.constant = 44.0 * 3.0
            } else {
                self.catItemsHeight.constant = 0
                self.isTableVisible = false
            }
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func uploadTickScan(_ sender: Any) {
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
            ticketScan.image = image
            
        }
        else
        {
            //Error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func featuredFlight(_ sender: UISwitch) {
        if(sender.isOn == true){
            self.featured = 2
            self.featuredTill.isEnabled = true
            self.featuredTill.isHidden = false
        }else{
             self.featured = 1
              self.featuredTill.isEnabled = false
            self.featuredTill.isHidden = true
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
                chooseCate.setTitle("Category Selected: \(choosenFinal)", for: .normal)
            }else{
                let choosenFinal  = choosen.joined(separator: ",")
                chooseCate.setTitle("Category Selected: \(choosenFinal)", for: .normal)
            }
            
            
            UIView.animate(withDuration: 0.5) {
                self.catItemsHeight.constant = 0
                self.isTableVisible = false
                self.view.layoutIfNeeded()
            }
            self.catItems.reloadData()
            
        }else{
            recievers?.isSelected = true
            self.chooseCats.append((recievers?.id)!)
            self.chooseCatsString.append((recievers?.name)!)
            let choosen = self.chooseCatsString
            if(choosen.count < 1 || choosen.count == 1 ){
                let choosenFinal  = choosen.joined(separator: " ")
                chooseCate.setTitle("Category Selected: \(choosenFinal)", for: .normal)
            }else{
                let choosenFinal  = choosen.joined(separator: ",")
                chooseCate.setTitle("Category Selected: \(choosenFinal)", for: .normal)
            }
            UIView.animate(withDuration: 0.5) {
                self.catItemsHeight.constant = 0
                self.isTableVisible = false
                self.view.layoutIfNeeded()
            }
            self.catItems.reloadData()
        }
        
        
    }
    func getCategries(){
        
        GetCategories.GetCategories{(categories, error) in
            
            if(error == ""){
                self.categoriesResp = categories
                self.catItems.reloadData()
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
    //goToAirlines
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "goToAirlines"){
            let destination = segue.destination as! AirLinesViewController
            destination.typeAddEdit = self.typeAddEdit
            destination.delegateDes = self
           
        }else{
            let destination = segue.destination as! AirPortCountryViewController
            destination.airPortWay = self.airPortWay
             destination.typeAddEdit = self.typeAddEdit
            destination.countriesRes = self.countriesRes
            
        }
    }
    
    func AirLineBag(_ airline: String?, _ id: Int?) {
        
         bagAirLineId = id!
         bagAirLineName = airline!
    }
    
    func AirPortBag(_ airline: String?, _ id: Int?) {
         bagAirDepartureAiportId = id!
         bagAirDepartureName = airline!
        
    }
    
    func AirPortBagDes(_ airline: String?, _ id: Int?) {
         bagAirDestinationAiportId = id!
         bagAirDestinationName = airline!
    }
    
    /*
     departure date time
     feature date only
      avail from to  time only
     
     */
    
    func createDatePicker1(){
        //format for datepicker display
        datePicker1.datePickerMode = .dateAndTime
        //assign datepicker to our textfield
        departureTime.inputView = datePicker1
        //create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //add a done button on this toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClickedDT))
        toolbar.setItems([doneButton], animated: true)
        departureTime.inputAccessoryView = toolbar
    }
   
    @objc func doneClickedDT(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        departureTime.text = dateFormatter.string(from: datePicker1.date)
        
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute, .day, .month, .year], from: datePicker1.date)
        let minute = comp.minute
        var minutes = ""
        if minute! < 10 {
            minutes = "0" + "\(String(describing: minute!))"
        }else{
            minutes = "\(String(describing: minute!))"
            
        }
        
        let date = "\(comp.year!)" + "-" + "\(comp.month!)" + "-" +  "\(comp.day!)" + " " + "\(comp.hour!)" + ":" + minutes
        print(date)
        self.departureDateTime = date
        self.view.endEditing(true)
    }

    func createDatePicker2(){
        //format for datepicker display
        datePicker2.datePickerMode = .date
        //assign datepicker to our textfield
        featuredTill.inputView = datePicker2
        //create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //add a done button on this toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClickedFT))
        toolbar.setItems([doneButton], animated: true)
        featuredTill.inputAccessoryView = toolbar
    }
    @objc func doneClickedFT(){
        
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .medium
            featuredTill.text = dateFormatter.string(from: datePicker2.date)
            
            
            //format for displaying the date in our textfield
            let calendar = Calendar.current
            let comp = calendar.dateComponents([.day, .month, .year], from: datePicker2.date)
            let date = "\(comp.year!)" + "-" + "\(comp.month!)" + "-" +  "\(comp.day!)"
            self.featureDate = date
            self.view.endEditing(true)
        

    }
    
    
    
    
    
    func createDatePicker3(){
        //format for datepicker display
        datePicker3.datePickerMode = .time
        //assign datepicker to our textfield
        bagAvialFrom.inputView = datePicker3
        //create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //add a done button on this toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClickedAvailFrom))
        toolbar.setItems([doneButton], animated: true)
        bagAvialFrom.inputAccessoryView = toolbar
    }
    @objc func doneClickedAvailFrom(){
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute], from: datePicker3.date)
        let hour = comp.hour
        let minute = comp.minute
        
        var minutes = ""
        if minute! < 10 {
            minutes = "0" + "\(String(describing: minute!))"
        }else{
            minutes = "\(String(describing: minute!))"
            
        }
        
        self.bagAvialFrom.text = "\(String(describing: hour!)):\(String(describing: minutes))"
        self.availableFrom = self.bagAvialFrom.text!
        self.view.endEditing(true)
    }
    
    
    func createDatePicker4(){
        //format for datepicker display
        datePicker4.datePickerMode = .time
        //assign datepicker to our textfield
        bagAvialTo.inputView = datePicker4
        //create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //add a done button on this toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClickedAvailTo))
        toolbar.setItems([doneButton], animated: true)
        bagAvialTo.inputAccessoryView = toolbar
    }
    @objc func doneClickedAvailTo(){
        let calendar = Calendar.current
        
        let comp = calendar.dateComponents([.hour, .minute], from: datePicker4.date)
        let hour = comp.hour
        let minute = comp.minute
        
        var minutes = ""
        if minute! < 10 {
            minutes = "0" + "\(String(describing: minute!))"
        }else{
             minutes = "\(String(describing: minute!))"
            
        }
        
        self.bagAvialTo.text = "\(String(describing: hour!)):\(String(describing: minutes))"
        self.availableTo =  self.bagAvialTo.text!
        self.view.endEditing(true)
    }
    func createAlert(title : String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: ConstantStrings.yes, style: UIAlertActionStyle.default, handler: { (action) in
            
        }))
        alert.addAction(UIAlertAction(title:ConstantStrings.no , style: UIAlertActionStyle.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    func createAlertSuccess(title : String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: ConstantStrings.yes, style: UIAlertActionStyle.default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
       
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func addNewBag(_ sender: Any) {
        let imageData = self.ticketScan.image?.jpeg(.lowest)
        print(imageData?.count ?? 0)
        let strBase64 = imageData?.base64EncodedString(options: .lineLength64Characters)
        print(strBase64 ?? "")
        self.ticketScanString = strBase64!
        if(bagAirLineId == 0 || self.availableWeight.text! == "" || self.kgWeightPrice.text! == "" || self.m3WeightPrice.text! == "" || self.deartureMob.text! == "" || self.destinationMob.text! == "" || flightNumber.text == "" ||  departureDateTime == "" ||  availableFrom == "" || availableTo == "" ){
           createAlert(title: ConstantStrings.pleaseFillRequired)
        }else{
            
            if(AbstractViewController.validateNum(number: self.availableWeight.text!)){
                print("num yes ")
                self.available_weight = Double(self.availableWeight.text ?? "") ?? 0.0
                self.kg_price = Double(self.kgWeightPrice.text ?? "") ?? 0.0
                self.m3_price = Double(self.m3WeightPrice.text ?? "") ?? 0.0
               
                if(self.ticketScan.image != nil ){
                     let imageData = self.ticketScan.image?.jpeg(.lowest)
                    print(imageData?.count ?? 0)
                    let strBase64 = imageData?.base64EncodedString(options: .lineLength64Characters)
                    print(strBase64 ?? "")
                    self.ticketScanString = strBase64!
                    let defaults = UserDefaults.standard

                    defaults.set( self.ticketScanString, forKey: "ticketScanString")
                 
                }else{
                    self.ticketScanString = ""
                }
                var featuredDates = ""
                if(featureSwitc.isOn == true){
                    featured = 2
                    featuredDates = self.featureDate
                }else{
                     featured = 1
                     featuredDates = ""
                }
                var catss = [Int]()
                if(chooseCats.count == 0){
                    catss = []
                }else{
                   catss = self.chooseCats
                }
                  var catsstring = [String]()
                if(self.addNewCategories.text != ""){
                let fullName = self.addNewCategories.text!
                let dateTime = fullName.components(separatedBy: " ")

                    if(dateTime.count == 0){
                        catsstring = [""]
                    }else{
                        catsstring = dateTime
                        _ = catsstring.joined(separator: ",")
                    }
                }
                
               
                if(AbstractViewController.validateNum(number: self.destinationMob.text!) || AbstractViewController.validateNum(number: self.deartureMob.text!)  ){
                    print("num yes ")
                    

                    self.createBag(available_weight: self.available_weight, kg_price: self.kg_price, m3_price: self.m3_price, departure_mobile: self.deartureMob.text!, destination_mobile: self.destinationMob.text!, flight_number: self.flightNumber.text!, featured: self.featured, featured_till: featuredDates, ticket_scan: ticketScanString, departure: bagAirDepartureAiportId, destination: bagAirDestinationAiportId, airline_id: bagAirLineId, departure_datetime: self.departureDateTime, categories_restrictions: catss, new_categories: catsstring, not_available_from: self.availableFrom, not_available_to: self.availableTo )
                }else{
                    createAlert(title: "Please enter valid number!")
                }
                
            }else{
               createAlert(title: "Please enter valid Bag Weight!")
            }
            
            
            
            
        }
    }
    
    public enum ImageFormat {
        case png
        case jpeg(CGFloat)
    }
    
    func convertImageTobase64(format: ImageFormat, image:UIImage) -> String? {
        var imageData: Data?
        switch format {
        case .png: imageData = UIImagePNGRepresentation(image)
        case .jpeg(let compression): imageData = UIImageJPEGRepresentation(image, compression)
        }
        return imageData?.base64EncodedString()
    }
    /*
     
     available_weight : Double , kg_price : Double ,m3_price : Double, departure_mobile : String, destination_mobile : String, flight_number : String, featured : Int , featured_till : String, ticket_scan : String, departure  : Int , destination : Int , airline_id  : Int , departure_datetime : String, categories_restrictions : [Int],
       new_categories : [string], not_available_from : String, not_available_to : String
     */
    
    func createBag(available_weight : Double , kg_price : Double ,m3_price : Double, departure_mobile : String, destination_mobile : String, flight_number : String, featured : Int , featured_till : String, ticket_scan : String, departure  : Int , destination : Int , airline_id  : Int , departure_datetime : String, categories_restrictions : [Int],
                        new_categories : [String], not_available_from : String, not_available_to : String){
          hud.show(in: self.view)
        CretaeBag.CretaeBag(type: 2, bagId: 0, available_weight : available_weight , kg_price : kg_price ,m3_price : m3_price, departure_mobile : departure_mobile, destination_mobile : destination_mobile, flight_number : flight_number, featured : featured , featured_till : featured_till, ticket_scan : ticket_scan, departure  : departure , destination : destination , airline_id  : airline_id , departure_datetime : departure_datetime, categories_restrictions : categories_restrictions,
                            new_categories : new_categories, not_available_from : not_available_from, not_available_to : not_available_to) { (success, error) in
                                self.hud.dismiss()
                                if(error == "" )
                                { // msg = "bag is created successfully :) ";
                                    self.createAlertSuccess(title: "This bag has been created successfully!")
                                   
                                }
        }
        
    }
    
    func setUpViews(){
        for info in  (self.bagResp?.bagInfo)!{
            let weight = info.availableWeight!
            self.availableWeight.text = "\(weight)"
            let kgPrice = info.kgPrice!
            self.kgWeightPrice.text = "\(kgPrice)"
            let m3Price = info.m3Price!
            self.m3WeightPrice.text = "\(m3Price)"
            self.destinationAir.text =  info.destinationName
            self.departureAir.text = info.departureName
            self.deartureMob.text = info.departureMobile
            self.destinationMob.text = info.destinationMobile as? String
            self.flightNumber.text = info.flightNumber
            self.departureTime.text = info.departureDatetime
            self.airLineLabel.text = info.airlineName
            self.bagAvialFrom.text = "From: " + info.notAvailableFrom!
            self.bagAvialTo.text = "To: " + info.notAvailableTo!
            self.bagId = info.id!
            
            
            
    }
    }
    
    func aiLines(){
     for info in  (self.bagResp?.bagInfo)!{
        self.destinationAir.text =  info.destinationName
        self.departureAir.text = info.departureName
           self.airLineLabel.text = info.airlineName
        departureDateTime = info.departureDatetime!
        availableFrom = info.notAvailableFrom!
        availableTo = info.notAvailableTo!
   
        }
    }
}
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
}

