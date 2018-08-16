//
//  AbstractViewController.swift
//  AirBag
//
//  Created by Geek on 8/16/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit

class AbstractViewController: UIViewController {

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
    
    class func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character: [!$@#%])
    class func isValidPasword(testStr: String) -> Bool {
        let password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*&#^])[A-Za-z\\d$@$!%*&#^]{8,}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", password)
        return passwordTest.evaluate(with: testStr)
    }
    
    class func validateFeildsRegister(firstName: String,lastName: String, password : String,confirmPassword : String,email: String, phone : String) -> Bool{
        if(firstName.isEmpty == true || password.isEmpty == true || email.isEmpty == true || firstName == "" ||  password == ""  || email == "" || lastName.isEmpty == true || lastName == "" ||  confirmPassword == ""  || confirmPassword.isEmpty == true ||  phone == ""  || phone .isEmpty == true){
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

}
