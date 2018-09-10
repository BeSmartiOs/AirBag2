//
//  VerifyNumberViewController.swift
//  AirBag
//
//  Created by Geek on 8/30/18.
//  Copyright © 2018 Geek. All rights reserved.
//



/*
 
 active states:
 0- just registered
 1- only mobile activation is done
 2- only email activation is done
 3- email and mobile activation are done
 .. user can open app now
 */

import UIKit

class VerifyNumberViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var verificationCode: UITextField!
    
    @IBOutlet weak var updatePhoneNumbr: UITextField!
    
    @IBOutlet weak var resendBtn: UIButton!
    
    @IBOutlet weak var verifyBtn: UIButton!
    
    let userDefaults = UserDefaults.standard
    var userId  = 0
    var phone = ""
    var viewController : UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        self.updatePhoneNumbr.isEnabled = false
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
  
    @IBAction func verify(_ sender: Any) {
        if(self.verificationCode.text != ""){
            if(AbstractViewController.validateNum(number: self.verificationCode.text!)){
                if(AbstractViewController.validateNumCount(number: self.verificationCode.text!)){
                    print("yess")
                    if(AbstractViewController.validateNum(number: self.updatePhoneNumbr.text!)){
                        self.verifyPhone(userId : self.userId, code : self.verificationCode.text!)
                    }
                }else{
                     print("no")
                }
            }
        }else{
            
        }
    }
    //not done yet
    @IBAction func resend(_ sender: Any) {
       
        self.updatePhoneNumbr.isEnabled = true
        
      
        
    }

    func setUpView(){
        self.userId  = userDefaults.integer(forKey: "currentUserId")
        self.phone = userDefaults.string(forKey: "currentUserMobile")!
        self.updatePhoneNumbr.text = phone
    }
    
    func verifyPhone(userId : Int, code : String){
        
        RegisterApi.ActivateMobile(code: code, userId: userId) { (success, error) in
            if(error == ""){
                
                
                /*
                 
                 active states:
                 0- just registered
                 1- only mobile activation is done
                 2- only email activation is done
                 3- email and mobile activation are done
                 .. user can open app now
                 */
                if(success?.msg == "success"){
                    if(success?.content?.active == 1){
                     self.creatAlertActivate(tite: "Phone Activated!")
                    }else if(success?.content?.active == 3){
                        self.creatAlert(tite : "Account verified successfully")
                      
                    }
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "activateEmail"){
            let destination = segue.destination as! ActivateEmailViewController
            destination.title = "Verify Email"
            
            
        }
    }
    
    func creatAlert(tite : String){
        // create the alert
        let alert = UIAlertController(title: tite, message: "", preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
            let storyboardMain = UIStoryboard(name : Constants.StroyBoards.mainStoryBoard, bundle: nil)
            let mainViewController = storyboardMain.instantiateViewController(withIdentifier: "loginView") as! UINavigationController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = mainViewController
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    func creatAlertActivate(tite : String){
        // create the alert
        let alert = UIAlertController(title: tite, message: "", preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
       self.performSegue(withIdentifier: "activateEmail", sender: self)
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
}
