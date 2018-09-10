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
    let userDefaults = UserDefaults.standard
    var userTypeChanges : Int?
    
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
  /*  static let carrier = 1
    static let sender = 2
    static let reciever = 3 */
    
    @IBAction func beSenderAction(_ sender: Any) {
       self.userTypeChanges = 2
        createAlert(title: ConstantStrings.sureSender)
    }
    
    
    @IBAction func beCarrierAction(_ sender: Any) {
        self.userTypeChanges = 1
        createAlert(title: ConstantStrings.sureCarrier)
       
    }
    
    
    
    @IBAction func beRecieverAction(_ sender: Any) {
        self.userTypeChanges = 3
        createAlert(title: ConstantStrings.sureRec)
    
        
    }
    
    
    @IBAction func logOutBtn(_ sender: Any) {
        self.createAlertLogout(title: ConstantStrings.confirmLogout)
    }
    
    
    @IBAction func notificationBtn(_ sender: Any) {
        let des = UIStoryboard(name: "Common", bundle: nil).instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
        self.navigationController?.pushViewController(des, animated: true)
    }
    
    
    @IBAction func profile(_ sender: Any) {
        let des = UIStoryboard(name: "Common", bundle: nil).instantiateViewController(withIdentifier: "ProfilesViewController") as! ProfilesViewController
        self.navigationController?.pushViewController(des, animated: true)
    }
    
    func setUpsViews(){
      self.beSender.setTitle(ConstantStrings.beSender, for: .normal)
        self.beCarrier.setTitle(ConstantStrings.beCarrier, for: .normal)
        self.beReciever.setTitle(ConstantStrings.beReciever, for: .normal)
        self.notifications.setTitle(ConstantStrings.notifications, for: .normal)
        self.logOut.setTitle(ConstantStrings.logOut, for: .normal)
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginContentt
        if(decodedUser.currentTypeId == 1){
              self.beCarrier.setTitle(ConstantStrings.alreadyCarrier, for: .normal)
            self.beCarrier.isEnabled = false
        }else  if(decodedUser.currentTypeId == 2){
               self.beSender.isEnabled = false
               self.beSender.setTitle(ConstantStrings.alreadySender, for: .normal)
        }else{
               self.beReciever.isEnabled = false
                 self.beReciever.setTitle(ConstantStrings.alreadyRec, for: .normal)
        }
        
    }
    
    func logOutFromApp(){
        let idForUserDefaults = "logResp"
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: idForUserDefaults)
        userDefaults.removeObject(forKey: "currentUserId")
        userDefaults.removeObject(forKey: "currentUserEmail")
        userDefaults.removeObject(forKey: "currentUserMobile")
        userDefaults.synchronize()
        print(userDefaults.data(forKey: "logResp")?.count ?? 0)
        print(userDefaults.integer(forKey: "currentUserId") )
        print(userDefaults.string(forKey: "currentUserEmail") ?? "")
        print(userDefaults.string(forKey: "currentUserMobile") ?? "")
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
    func createAlert(title : String){
    let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: ConstantStrings.yes, style: UIAlertActionStyle.default, handler: { (action) in
   
    }))
    alert.addAction(UIAlertAction(title:ConstantStrings.no , style: UIAlertActionStyle.destructive, handler: nil))
    self.present(alert, animated: true, completion: nil)
    
    
    }
   
}
