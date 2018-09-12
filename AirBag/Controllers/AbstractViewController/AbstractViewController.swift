//
//  AbstractViewController.swift
//  AirBag
//
//  Created by Geek on 8/16/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit
import Reachability
import JGProgressHUD

class AbstractViewController: UIViewController {

    
       let hud = JGProgressHUD(style: .light)
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
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
//    class func showHud() {
//         hud.textLabel.text = ConstantStrings.pleaseWait
//    }
    
    class func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character: [!$@#%])
    class func isValidPasword(testStr: String) -> Bool {
        let password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%&#^])[A-Za-z\\d$@$!%&#^]{8,}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", password)
        return passwordTest.evaluate(with: testStr)
    }
    
    class func validateFeildsRegister(firstName: String,lastName: String, password : String,confirmPassword : String,email: String, phone : String, address : String) -> Bool{
        if(firstName.isEmpty == true || password.isEmpty == true || email.isEmpty == true || firstName == "" ||  password == ""  || email == "" || lastName.isEmpty == true || lastName == "" ||  confirmPassword == ""  || confirmPassword.isEmpty == true ||  phone == ""  || phone .isEmpty == true || address.isEmpty == true ||  address == ""){
            return false
        }else{
            return true
        }
        
    }
    
    class func validateLogin(userType: Int,email: String, password : String) -> Bool{
        if( password == ""  || email == ""  || password.isEmpty == true || email.isEmpty == true || userType == 0){
            return false
        }else{
            return true
        }
        
    }
    
    class func validateNum(number: String) -> Bool{
        
        let numbersTest = number
        if let number = Int(numbersTest){
            print(number)//contains onlyy number
             return true
        }else{
            print("notnumber")//Not number
             return false
        }
    }
    
    class func validateNumCount(number: String) -> Bool{
        let numbersTest = number
        if let number = Int(numbersTest){
            print(number)//contains onlyy number
            if(numbersTest.count == 6){
                return true
            }else{
            return false
            }
        }else{
            print("notnumber")//Not number
            return false
        }
    }
    
    
    class func validateNumDouble(number: String) -> Bool{
        
        let numbersTest = number
        if let number = Double(numbersTest){
            print(number)//contains onlyy number
            return true
        }else{
            print("notnumber")//Not number
            return false
        }
    }
    
    //MARK:- Connectivity Func
    class func connected() -> Bool {
        let reachability = Reachability()!
        if reachability.connection != .none {
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            return true
        } else {
            print("Network not reachable")
            return false
        }
    }
    
    //
    // Convert String to base64
    //
    class func convertImageToBase64(image: UIImage) -> String {
        let imageData = UIImagePNGRepresentation(image)!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        print(imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters))
    }
    
    //
    // Convert base64 to String
    //
    class func convertBase64ToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
}
