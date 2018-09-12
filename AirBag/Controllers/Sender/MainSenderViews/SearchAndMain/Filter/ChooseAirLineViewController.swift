//
//  ChooseCountriesViewController.swift
//  AirBag
//
//  Created by Geek on 8/15/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit
import  JGProgressHUD



protocol classAirLine: class {
    func classAirLines(_ airine: String?, _ id : Int?)
    
}

protocol classCarrier: class {
    func classCarriers(_ name: String?, _ id : Int?)
    
}
class ChooseAirLineViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
    

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var airLineTableView: UITableView!
    @IBOutlet weak var myNavBarItem: UINavigationItem!
    weak var airLines : classAirLine?
    weak var carriers : classCarrier?
    var choosenAirLine = ""
    var choosenAirLineId : Int?
    let hud = JGProgressHUD(style: .light)
    var airlinesRes : [Airlines]?
    var recieversUsers : [UsersResp]?
    var type : Int?
  
    override func viewDidLoad() {
        super.viewDidLoad()
       self.hud.textLabel.text = ConstantStrings.pleaseWait
     
    
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       
        if(type == 1){
            getAirLines()
             myNavBarItem.title = ConstantStrings.airLines
        }else{
            getRecievers()
        }
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(type == 1){
        if(self.airlinesRes != nil){
            return (self.airlinesRes?.count)!
        }else{
            return 0
        }
        }else{
            if(self.recieversUsers != nil){
                return (self.recieversUsers?.count)!
            }else{
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCitiesCell", for: indexPath) as! ChooseCtitesTableViewCell
       
        if(type == 1){
            cell.countryCity.text = self.airlinesRes?[indexPath.row].name
        }else{
            cell.countryCity.text = self.recieversUsers?[indexPath.row].nickname
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(type == 1){
        self.choosenAirLine = (self.airlinesRes?[indexPath.row].name)!
        self.choosenAirLineId = (self.airlinesRes?[indexPath.row].id)!
         self.airLines?.classAirLines((self.airlinesRes?[indexPath.row].name)!, (self.airlinesRes?[indexPath.row].id)!)
        }else{
              self.carriers?.classCarriers((self.recieversUsers?[indexPath.row].nickname)!, (self.recieversUsers?[indexPath.row].id)!)
            self.createAlertSuccess(title: ConstantStrings.viewCarrierData)
        }
        

      
    }
   
    
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
       self.navigationController?.popViewController(animated: true)
    }

    func getAirLines(){
            hud.show(in: self.view)
        GetCountriesCities.GetAirLines { (airlines, error) in
               self.hud.dismiss()
            if(error == ""){
                
                self.airlinesRes = airlines
                self.airLineTableView.reloadData()
            }
        }
        
    }
    func getRecievers(){
          hud.show(in: self.view)
        GetRecievers.GetRecievers { ( users, error) in
              self.hud.dismiss()
            if(error == ""){
                
                self.recieversUsers = users
                self.airLineTableView.reloadData()
            }
        }
        
    }
    func createAlertSuccess(title : String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: ConstantStrings.yes, style: UIAlertActionStyle.default, handler: { (action) in
           self.goToCarrierInfo()
        }))
        alert.addAction(UIAlertAction(title: ConstantStrings.no, style: UIAlertActionStyle.destructive, handler: { (action) in
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func goToCarrierInfo(){
        let popOverVC = UIStoryboard(name : Constants.StroyBoards.commonStoryBoard, bundle: nil).instantiateViewController(withIdentifier: "ProfilesViewController") as! ProfilesViewController
        popOverVC.typeFrom = 1
        self.navigationController?.pushViewController(popOverVC, animated: true)
        
    }
}



