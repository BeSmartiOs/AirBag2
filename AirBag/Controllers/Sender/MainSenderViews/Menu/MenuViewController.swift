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
        setUpsViews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "goToNotifications"){
            let destination = segue.destination as! NotificationsViewController
            
        }
    }
   
    @IBAction func beSenderAction(_ sender: Any) {
    }
    
    
    @IBAction func beCarrierAction(_ sender: Any) {
    }
    
    
    
    @IBAction func beRecieverAction(_ sender: Any) {
    }
    
    
    @IBAction func logOutBtn(_ sender: Any) {
        self.createAlertLogout(title: ConstantStrings.confirmLogout)
    }
    
    
    @IBAction func notificationBtn(_ sender: Any) {
        performSegue(withIdentifier: "goToNotifications", sender: self)
    }
    
    func setUpsViews(){
      self.beSender.setTitle(ConstantStrings.beSender, for: .normal)
        self.beCarrier.setTitle(ConstantStrings.beCarrier, for: .normal)
        self.beReciever.setTitle(ConstantStrings.beReciever, for: .normal)
        
        
        self.notifications.setTitle(ConstantStrings.notifications, for: .normal)
        self.logOut.setTitle(ConstantStrings.logOut, for: .normal)
        
    }
    
    func logOutFromApp(){
        let idForUserDefaults = "logResp"
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: idForUserDefaults)
        userDefaults.synchronize()
        print(userDefaults.data(forKey: "logResp")?.count ?? 0)
        
                let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
                let mainViewController = storyboardMain.instantiateViewController(withIdentifier: "loginView") as! UINavigationController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = mainViewController
    }
    
    func createAlertLogout(title : String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: ConstantStrings.yes, style: UIAlertActionStyle.default, handler: { (action) in
            self.logOutFromApp()
        }))
        alert.addAction(UIAlertAction(title:ConstantStrings.no , style: UIAlertActionStyle.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
   
}
