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
    
    var bagId = 0
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

    }
    @objc func addItems(){
        performSegue(withIdentifier: "goToAddItems", sender: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if(items.count == 0){
            return 0
//        }else{
//            return items.count
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "senderCell", for: indexPath) as! MainSenderTableViewCell
      //  cell.fromLabel.text = items[indexPath.row].descripItem
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
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
        }
    }
}
