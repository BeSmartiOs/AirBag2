//
//  ChooseCityViewController.swift
//  AirBag
//
//  Created by Geek on 8/15/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit


protocol ChooseItemClass: class {
    func ChooseItem(_ item: String?, _ id : Int?)
}
class ChooseItemViewController: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    

    @IBOutlet weak var myNavBarItem: UINavigationItem!
    @IBOutlet weak var myNavigationBar: UINavigationBar!

    @IBOutlet weak var chooseItemTableView: UITableView!
    weak var delegate: ChooseItemClass?
    var choosenItemName = ""
    var choosenItemId = 0
       var choosenCatId = 0
    var itemsResponses : [ItemsInCategResp]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.navigationBar.isHidden = true
        self.getItems(id: self.choosenCatId)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if(self.itemsResponses != nil ){
            return (self.itemsResponses?.count)!
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCitiesCell", for: indexPath) as! ChooseCtitesTableViewCell
        cell.countryCity.text = self.itemsResponses?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate?.ChooseItem(self.itemsResponses?[indexPath.row].name, self.itemsResponses?[indexPath.row].id)
    }
    
    
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getItems(id :Int){
        GetCategories.GetCategoriesItems(catId: id) { (items, error) in
            if(error == ""){
                
                self.itemsResponses = items
                self.chooseItemTableView.reloadData()
            }
        }
        
    }
    
}

