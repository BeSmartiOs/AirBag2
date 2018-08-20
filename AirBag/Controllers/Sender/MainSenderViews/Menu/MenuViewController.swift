//
//  MenuViewController.swift
//  AirBag
//
//  Created by Geek on 8/19/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var beSender: UIButton!
    @IBOutlet weak var beCarrier: UIButton!
    @IBOutlet weak var beReciever: UIButton!
    
    
    @IBOutlet weak var notifications: UIButton!
    @IBOutlet weak var logOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customeCenterImage()
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
    @IBAction func beSenderAction(_ sender: Any) {
    }
    
    
    @IBAction func beCarrierAction(_ sender: Any) {
    }
    
    
    
    @IBAction func beRecieverAction(_ sender: Any) {
    }
    
    
    @IBAction func logOutBtn(_ sender: Any) {
    }
    
    
    @IBAction func notificationBtn(_ sender: Any) {
    }
   
}
