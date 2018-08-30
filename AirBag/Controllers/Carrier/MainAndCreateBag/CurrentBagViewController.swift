//
//  CurrentBagViewController.swift
//  AirBag
//
//  Created by Geek on 8/30/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit
import JGProgressHUD

class CurrentBagViewController: UIViewController {

    let userDefaults = UserDefaults.standard
    let hud = JGProgressHUD(style: .light)

    override func viewDidLoad() {
        super.viewDidLoad()
        customeCenterImage()
        hud.textLabel.text = ConstantStrings.pleaseWait
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

}
