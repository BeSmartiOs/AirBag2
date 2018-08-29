//
//  NotificationsViewController.swift
//  AirBag
//
//  Created by Geek on 8/28/18.
//  Copyright © 2018 Geek. All rights reserved.
//



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
class NotificationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var notificationTable: UITableView!
     let hud = JGProgressHUD(style: .light)
    var notificationsRes : NotificationResp?
    var nootId : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        customeCenterImage()
        hud.textLabel.text = ConstantStrings.pleaseWait
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getNotifiations()
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
        
        if(segue.identifier == "goToNotificationDetails"){
            let destination = segue.destination as! NotificationDetailsViewController
            destination.nootId = self.nootId
        }
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.notificationsRes != nil){
            
            return (self.notificationsRes?.content?.notifications?.count)!
            
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationTableViewCell
        cell.titleLabel.text = self.notificationsRes?.content?.notifications![indexPath.row].title
           cell.bodyLabel.text = self.notificationsRes?.content?.notifications![indexPath.row].body
        cell.isRead.backgroundColor = UIColor.appBlue
        cell.isRead.layer.cornerRadius = cell.isRead.frame.size.width/2
        cell.isRead.clipsToBounds = true
        
        if(self.notificationsRes?.content?.notifications![indexPath.row].seen! == "0000-00-00 00:00:00"){
            cell.isRead.isHidden = false
        }else{
                    cell.isRead.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.nootId = self.notificationsRes?.content?.notifications![indexPath.row].id
        performSegue(withIdentifier: "goToNotificationDetails", sender: self)
    }
    
    func getNotifiations(){
        hud.show(in: self.view)
        GetNotifications.GetNotifications { (notifications, error) in
            if(error == ""){
               self.hud.dismiss()
                self.notificationsRes = notifications
                self.notificationTable.reloadData()
            }else{
                 self.hud.dismiss()
                
            }
        }
        
    }
}
