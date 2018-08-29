//
//  MainSenderViewController.swift
//  AirBag
//
//  Created by Geek on 8/19/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit
import JGProgressHUD

class MainSenderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var senderTableView: UITableView!
    
    @IBOutlet weak var filterBtn: UIBarButtonItem!
    
    let sections = ["Available Featured Bag","Available Normal Bag"]
    var itemsA : [AvailableFeaturedBag]?
    var itemsB : [AvailableNormalBag]?
    var bagsResp : BagsResponse?
    let userDefaults = UserDefaults.standard
    var bagId = 0
    let hud = JGProgressHUD(style: .light)
    override func viewDidLoad() {
        super.viewDidLoad()
        customeCenterImage()
        hud.textLabel.text = ConstantStrings.pleaseWait
        getAvailableBags()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
         return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.bagsResp != nil){
        switch (section) {
        case 0:
            return itemsA!.count
        case 1:
            return itemsB!.count
        default:
                return 0
        }
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "senderCell", for: indexPath) as! MainSenderTableViewCell
        switch (indexPath.section) {
        case 0:
            cell.fromLabel.text = itemsA?[indexPath.row].departure
            cell.toLabel.text = itemsA?[indexPath.row].destination
          
            let price = itemsA?[indexPath.row].kgPrice
            let priceFinal = String(describing: price!)
            cell.costLabel.text = "$" + priceFinal
            
            let weight = itemsA?[indexPath.row].availableWeight
            let weightFinal = String(describing: weight!)
            cell.weightLabel.text = weightFinal
            
            let seen = itemsA?[indexPath.row].views
            let seenFinal = String(describing: seen!)
            cell.seenLabel.text = seenFinal
            
            break
     
        case 1:
              cell.fromLabel.text = itemsB?[indexPath.row].departure
              cell.toLabel.text = itemsB?[indexPath.row].destination
              let price = itemsB?[indexPath.row].kgPrice
              let priceFinal = String(describing: price!)
              cell.costLabel.text = "$" + priceFinal
              
              let weight = itemsB?[indexPath.row].availableWeight
              let weightFinal = String(describing: weight!)
              cell.weightLabel.text = weightFinal
              
              let seen = itemsB?[indexPath.row].views
              let seenFinal = String(describing: seen!)
              cell.seenLabel.text = seenFinal
         break
        default:
            
             break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
        
        switch (indexPath.section) {
        case 0:
            self.bagId = (itemsA?[indexPath.row].id)!
            break

        case 1:
            self.bagId = (itemsB?[indexPath.row].id)!
            break
        default:
            
            break
        }
        performSegue(withIdentifier: "goToBagDetails", sender: self)
    }
    
 
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if(segue.identifier == "goToBagDetails"){
            let destination = segue.destination as! BagDetailsViewController
            destination.bagId = self.bagId
        }
     }
    
    func getAvailableBags(){
        if(AbstractViewController.connected()){
        hud.show(in: self.view)
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginContentt
        GetAvailableBags.GetAvailableBags(departureId: 0, destinationId: 0, carrierId: 0, categoryId: 0, airlineId: 0, flightNumber: "0", aceessToken: decodedUser.token!, type: 0) { (response, error) in
            self.hud.dismiss()
            
            if(error == ""){
                self.bagsResp = response
                if(response?.availableFeaturedBags?.count != 0){
                    self.itemsA = response?.availableFeaturedBags
                    self.itemsB = response?.availableNormalBags
            }
                self.senderTableView.reloadData()
            
            }else{
                self.creatAlert(tite : "Please check Internet Connectivity!")
            }
    }
    
}else{
    creatAlert(tite : "Please check Internet Connectivity!")
    }
}
    
    func creatAlert(tite : String){
        // create the alert
        let alert = UIAlertController(title: tite, message: "", preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

}
