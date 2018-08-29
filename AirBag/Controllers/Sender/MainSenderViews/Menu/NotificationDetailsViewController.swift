//
//  NotificationDetailsViewController.swift
//  AirBag
//
//  Created by Geek on 8/29/18.
//  Copyright © 2018 Geek. All rights reserved.
//



/*
 carrier = 1 --> usertye id == 1 check role to carrier to perform action
sender = 2  --> usertye id == 2 check role to carrier to perform action
reciever = 3 --> usertye id == 3 check role to carrier to perform action
 
 */



/*
 bag created 1   -> bagid
 bag reserved 2 -> transId
 reservation confirmed by carrier 3  -> transId
 reservation cancel by carrier 4  -> transId
 reservation cancel by sender 5  -> transId
 reservation cancel for nonpayment 6  -> transId
 reservation cancel for no condirmation 7  -> transId
 rate sender 8  -> transId
 rate carrier 9  -> transId
 */


import UIKit
import JGProgressHUD

class NotificationDetailsViewController: UIViewController {
    
    @IBOutlet weak var actionPerformed: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seenLabel: UILabel!
    @IBOutlet weak var bodyText: UITextView!
    let hud = JGProgressHUD(style: .light)
    var nootId : Int?
    var notification : NotificationDetailsResp?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    hud.textLabel.text = ConstantStrings.pleaseWait
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpViews()
        getNotificationDetails(id : nootId!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func actionToPerform(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func getNotificationDetails(id : Int) {
         hud.show(in: self.view)
        GetNotifications.GetNotificationsDetails(notificationId: id) { (details, error) in
            if(error == ""){
                self.hud.dismiss()
                self.notification = details
                self.titleLabel.text = self.notification?.title
                self.bodyText.text = self.notification?.body
                 self.seenLabel.text = self.notification?.seen?.date
                let userDefaults = UserDefaults.standard
                let decoded  = userDefaults.object(forKey: "logResp") as! Data
                let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginContentt
                
          
                if((self.notification?.userTypeId)! == 1){ ///--> carrier
                    if((self.notification?.userTypeId)! == decodedUser.currentTypeId!){
                       self.actionPerformed.isHidden = true
                            }else{
                          self.actionPerformed.isHidden = false
                        self.actionPerformed.setTitle("Be a Carrier to view more Info", for: .normal)
                        if(self.notification?.notificationTypeId == 1){
                            //go to carrier bagId
                        }else if(self.notification?.notificationTypeId == 2){
                            //go to carrier transId
                        }
                            }
                    
                   
                    
                }else if((self.notification?.userTypeId)! == 2){ //--> sender
                                         //go to sender
                    
                    
                    if((self.notification?.userTypeId)! == decodedUser.currentTypeId!){
                        self.actionPerformed.isHidden = true
                    }else{
                         self.actionPerformed.setTitle("Be a Sender to view more Info", for: .normal)
                        if(self.notification?.notificationTypeId == 1){
                            //go to sender bagId
                        }else if(self.notification?.notificationTypeId == 2){
                            //go to sender transId
                        }
                    }
                    
                }else if((self.notification?.userTypeId)! == 3){  //--> rec
                                           //go to rec
                    
                    
                    if((self.notification?.userTypeId)! == decodedUser.currentTypeId!){
                          self.actionPerformed.isHidden = true
                    }else{
                        self.actionPerformed.setTitle("Be a Reciever to view more Info", for: .normal)
                        if(self.notification?.notificationTypeId == 1){
                            //go to rec bagId
                        }else if(self.notification?.notificationTypeId == 2){
                            //go to rec transId
                        }
                    }
                     }
                
                
                

               
            }else{
                self.hud.dismiss()
                
            }
        }
    }
    func setUpViews(){
        self.titleLabel.text = ""
        self.bodyText.text = ""
        self.seenLabel.text = ""
        self.bodyText.isScrollEnabled = false
        self.bodyText.isEditable = false
          self.bodyText.layer.cornerRadius = 15.0
    }
}

//                if((self.notification?.userTypeId)! == 1){ ///--> carrier
//
//
//                    if(self.notification?.notificationTypeId == 1){
//                         //go to carrier bagId
//                    }else if(self.notification?.notificationTypeId == 2){
//                         //go to carrier transId
//                    }
//
//                }else if((self.notification?.userTypeId)! == 2){ //--> sender
//                     //go to sender
//                }else{  //--> rec
//                       //go to rec
// }
