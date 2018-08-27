//
//  ReserveBagViewController.swift
//  AirBag
//
//  Created by Geek on 8/20/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit

var items = [BagItems]()

class ReserveBagViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   

    @IBOutlet weak var reservedTableView: UITableView!
    @IBOutlet weak var reserveBag: UIButton!
    var currentBag : BagDetialsResp?
    var bagId = 0
    var loadedCartStatic : [[String: Any]]?
    var itemName = [String]()
    var recieverName = [String]()
    var weight = [Double]()
    override func viewDidLoad() {
        super.viewDidLoad()
 
        customeCenterImage()
        setUpViews()
      
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {

        if let favorites = UserDefaults.standard.array(forKey: "\(self.bagId)") {
            if favorites.count == 0 {
                
                
            } else {
                
                let userDefaults = UserDefaults.standard
                let loadedCart = userDefaults.array(forKey: "\(self.bagId)") as? [[String: Any]]
                self.loadedCartStatic = loadedCart
                for item in self.loadedCartStatic! {
                    self.itemName.append(item["itemName"] as! String)
                     self.recieverName.append(item["recieverName"] as! String)
                     self.weight.append(item["weight"] as! Double)
                }
                self.reservedTableView.reloadData()
            }
        }else{
          
        }
        
        
    }
    @objc func addItems(){
        performSegue(withIdentifier: "goToAddItems", sender: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if(  self.loadedCartStatic == nil ){
            return 0
        }else{
        return (self.loadedCartStatic?.count)!
      }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell", for: indexPath) as! ItemsTableViewCell
        cell.itemName.text = self.itemName[indexPath.row]
        cell.carrierName.text = self.recieverName[indexPath.row]
         cell.weight.text = "\(self.weight[indexPath.row])"
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func reserveBagAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    func setUpViews(){
        let rightBarButton = UIBarButtonItem(title: "Add Items", style: UIBarButtonItemStyle.plain, target: self, action: #selector(addItems))
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.reserveBag.setTitle(ConstantStrings.reserveBag, for: .normal)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "goToAddItems"){
            let destination = segue.destination as! AddItemsInBagViewController
               destination.bagId = self.bagId
            destination.currentBag = self.currentBag
        }
    }
}
