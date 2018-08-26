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
    
    

    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var senderMob: UILabel!
    @IBOutlet weak var recieverName: UILabel!
    @IBOutlet weak var recieverMob: UILabel!
    @IBOutlet weak var departure: UILabel!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var transactionPrice: UILabel!
    
    @IBOutlet weak var itemTableView: UITableView!
     var transactionId = 0
    let hud = JGProgressHUD(style: .light)
    var transactionsDetails : TransactionDetailsResp?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTransactions(id : self.transactionId)
 hud.textLabel.text = ConstantStrings.pleaseWait
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemTransactions", for: indexPath) as! TransactionItemsTableViewCell
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func getTransactions(id : Int){
        hud.show(in: self.view)
        GetReservations.GetTransactionsDetails(transactionId: id) { (transactions, error) in
            self.hud.dismiss()
            if(error == ""){
                self.transactionsDetails = transactions
                for details in (transactions?.transaction)!{
                    self.senderName.text = details.carrierName
                    self.recieverName.text = details.receiverName
                    self.departure.text = details.departure
                    self.destination.text = details.destination
//                    self.transactionPrice.text = details.transactionPrice
//                    self.senderName.text = details.reservedWeight
             
                }
            
                
                self.itemTableView.reloadData()
            }
        }
    }
}
