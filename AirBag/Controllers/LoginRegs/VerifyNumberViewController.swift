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

class VerifyNumberViewController: UIViewController {

    
    @IBOutlet weak var verificationCode: UITextField!
    
    @IBOutlet weak var updatePhoneNumbr: UITextField!
    
    @IBOutlet weak var resendBtn: UIButton!
    
    @IBOutlet weak var verifyBtn: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    
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
    @IBAction func Next(_ sender: Any) {
    }
    @IBAction func verify(_ sender: Any) {
    }
    
    @IBAction func resend(_ sender: Any) {
    }
}
