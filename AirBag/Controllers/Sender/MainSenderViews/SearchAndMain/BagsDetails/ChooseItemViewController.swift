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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
      //  self.getCities(id: self.departureCountryId!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
            return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCitiesCell", for: indexPath) as! ChooseCtitesTableViewCell
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        self.delegate?.chooseDepartureCity(self.cityResp?[indexPath.row].name, self.cityResp?[indexPath.row].id)
    }
    
    
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    func getCities(id :Int){
        GetCountriesCities.GetCities(id: id) { (cities, error) in
            if(error == ""){
                self.chooseItemTableView.reloadData()
                
            }
        }
        
    }
    
}

