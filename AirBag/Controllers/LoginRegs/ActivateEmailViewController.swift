//
//  ActivateEmailViewController.swift
//  AirBag
//
//  Created by Geek on 9/2/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit

class ActivateEmailViewController: UIViewController {

    let userDefaults = UserDefaults.standard
    var userId  = 0
    var phone = ""
    
    @IBOutlet weak var upateEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Verify Email"
        setUpView()
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

    @IBAction func checkEmailVerification(_ sender: Any) {
        
        RegisterApi.ActivateEmail(code: "", userId: userId) { (success, error) in
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
                    if(success?.content?.active == 2){
                        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VerifyNumberViewController") as! VerifyNumberViewController
                        self.navigationController?.pushViewController(popOverVC, animated: true)
                    }
                    }else if(success?.content?.active == 3){
                        self.creatAlert(tite : "Account verified successfully")
                    
                    }
                }
            }
        }
    func creatAlert(tite : String){
        // create the alert
        let alert = UIAlertController(title: tite, message: "", preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
            let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboardMain.instantiateViewController(withIdentifier: "loginView") as! UINavigationController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = mainViewController
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
func setUpView(){
    self.userId  = userDefaults.integer(forKey: "currentUserId")
    self.phone = userDefaults.string(forKey: "currentUserEmail")!
    self.upateEmail.text = phone
}

}
