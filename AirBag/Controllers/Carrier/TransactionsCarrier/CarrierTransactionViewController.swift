//
//  CarrierTransactionViewController.swift
//  AirBag
//
//  Created by Geek on 9/9/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit
import JGProgressHUD

class CarrierTransactionViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let hud = JGProgressHUD(style: .light)
    var transactions : TransactionsRes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
          hud.textLabel.text = ConstantStrings.pleaseWait
        customeCenterImage()
        getTransactions()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->Int{
        if (self.transactions != nil){
            
            return (transactions?.transactions?.count)!
            
        }else{
            return 0
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "senderCell", for: indexPath) as! MainSenderTableViewCell
        

        cell.fromLabel.text = self.transactions?.transactions![indexPath.row].departure
        cell.toLabel.text = self.transactions?.transactions![indexPath.row].destination
        
        let price = self.transactions?.transactions![indexPath.row].transactionPrice
        let priceFinal = String(describing: price!)
        cell.costLabel.text = "$" + priceFinal
        
        let weight = self.transactions?.transactions![indexPath.row].reservedWeight
        let weightFinal = String(describing: weight!)
        cell.weightLabel.text = weightFinal
        
        let carrier = self.transactions?.transactions![indexPath.row].receiverName
        let carrierFinal = String(describing: carrier!)
        cell.seenLabel.text = carrierFinal
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func getTransactions(){
        hud.show(in: self.view)
        GetReservations.GetTransactions { (transactions, error) in
            self.hud.dismiss()
            if(error == ""){
                self.transactions = transactions
                self.tableView.reloadData()
            }
        }
        
    }
}
