//
//  TransactionDetailsViewController.swift
//  AirBag
//
//  Created by Geek on 8/26/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit
import JGProgressHUD
class TransactionDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var noTransactionAvail: UILabel!
    @IBOutlet weak var carrierName: UILabel!
    @IBOutlet weak var recieverName: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var departure: UILabel!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var transactionPrice: UILabel!
    
    @IBOutlet weak var itemTableView: UITableView!
    
    
    @IBOutlet weak var declineBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var btnsHeight: NSLayoutConstraint!
    
     var transactionId = 0
    let hud = JGProgressHUD(style: .light)
    var transactionsDetails : TransactionDetailsResp?
    var transactionDetailsItems : [TransactionDetailsItems]?
    let userDefaults = UserDefaults.standard
    var currentUserType : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noTransactionAvail.text = ""
        getTransactions(id : self.transactionId)
        hud.textLabel.text = ConstantStrings.pleaseWait
       self.btnsHeight.constant = 0
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let decoded  = userDefaults.object(forKey: "logResp") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginContentt
        self.currentUserType = decodedUser.currentTypeId!
        /*
         static let carrier = 1
         static let sender = 2
         static let reciever = 3
         */
        if(self.currentUserType == 1){
             self.btnsHeight.constant = 30
            self.declineBtn.isHidden = false
            self.confirmBtn.isHidden = false
        }else{
             self.btnsHeight.constant = 0
            self.declineBtn.isHidden = true
            self.confirmBtn.isHidden = true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.transactionDetailsItems != nil){
            
            return (transactionDetailsItems?.count)!
            
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemTransactions", for: indexPath) as! TransactionItemsTableViewCell
        cell.itemName.text = self.transactionDetailsItems![indexPath.row].itemName
        let price =  self.transactionDetailsItems![indexPath.row].itemPrice
        let priceFinal = String(describing: price!)
        cell.peice.text = "$" + priceFinal
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.currentUserType == 3){
            performSegue(withIdentifier: "viewQrCode", sender: self)
        }

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "viewQrCode"){
            _ = segue.destination as! ViewQrCodeViewController
        }
    }
   
    func getTransactions(id : Int){
        hud.show(in: self.view)
        GetReservations.GetTransactionsDetails(transactionId: id) { (transactions, error) in
            self.hud.dismiss()
            if(error == ""){
                self.transactionsDetails = transactions
                for details in (transactions?.transaction)!{
                    self.carrierName.text = details.carrierName
                    self.recieverName.text = details.receiverName
                    self.departure.text = details.departure
                    self.destination.text = details.destination
                    
                    let price = details.transactionPrice
                    let priceFinal = String(describing: price!)
                    self.transactionPrice.text = "$" + priceFinal
                    
                    let weight = details.reservedWeight
                    let weightFinal = String(describing: weight!)
                    self.weight.text = weightFinal

                    self.dateTime.text = details.departureDatetime
             
                }
                if(self.transactionsDetails?.transactionItems?.count == 0){
                    self.itemTableView.isHidden = true
                    self.noTransactionAvail.text = "No Transaction Items"
                }else{
                     self.itemTableView.isHidden = false
                    self.transactionDetailsItems = self.transactionsDetails?.transactionItems
                     self.itemTableView.reloadData()
                }
            
                
               
            }
        }
    }
}
