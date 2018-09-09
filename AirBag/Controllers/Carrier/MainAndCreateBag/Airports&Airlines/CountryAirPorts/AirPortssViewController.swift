//
//  ChooseCityViewController.swift
//  AirBag
//
//  Created by Geek on 8/15/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit

protocol ClassAirPortBag: class {
    func AirPortBag(_ airline: String?, _ id : Int?)
}


protocol ClassAirPortBagDes: class {
    func AirPortBagDes(_ airline: String?, _ id : Int?)
}

class AirPortssViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate  {
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var myNavBarItem: UINavigationItem!
    @IBOutlet weak var myNavigationBar: UINavigationBar!
    @IBOutlet weak var countryCityTableView: UITableView!
    var departureCityId : Int?
    var cityResp : [Airlines]?
    var cityRespFilter : [Airlines]?
    weak var delegateDep: ClassAirPortBag?
    weak var delegateDes: ClassAirPortBagDes?
     var airPortWay : Int?
        var typeAddEdit : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        self.navigationItem.title = "Choose AirPort"
        // self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getAirPorts(id: self.departureCityId!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.cityResp != nil){
            return (self.cityResp?.count)!
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCitiesCell", for: indexPath) as! ChooseCtitesTableViewCell
        cell.countryCity.text = self.cityResp?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(airPortWay == 1){
                delegateDep?.AirPortBag(self.cityResp?[indexPath.row].name!, self.cityResp?[indexPath.row].id!)
           
            if(self.typeAddEdit == "addBag"){
                bagAirDepartureAiportId = (self.cityResp?[indexPath.row].id!)!
                bagAirDepartureName = (self.cityResp?[indexPath.row].name!)!
            }else{
                editbagAirDepartureAiportId = (self.cityResp?[indexPath.row].id!)!
                editbagAirDepartureName = (self.cityResp?[indexPath.row].name!)!
            }
            
           
          
            
        }else{
            
                delegateDes?.AirPortBagDes(self.cityResp?[indexPath.row].name!, self.cityResp?[indexPath.row].id!)
             if(self.typeAddEdit == "addBag"){
             bagAirDestinationAiportId = (self.cityResp?[indexPath.row].id!)!
            bagAirDestinationName = (self.cityResp?[indexPath.row].name!)!
            }else{
                editbagAirDestinationAiportId = (self.cityResp?[indexPath.row].id!)!
                editbagAirDestinationName = (self.cityResp?[indexPath.row].name!)!
            }
        }

    
    }
   
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
         self.navigationController?.popViewController(animated: true)
    }
    //MARK: Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.cityResp = self.cityRespFilter?.filter({ animal -> Bool in
            if searchText.isEmpty { return true }
            return animal.name!.lowercased().contains(searchText.lowercased())
        })
        self.countryCityTableView.reloadData()
    }
    func getAirPorts(id :Int){
        GetCountriesCities.GetAirPorts(id: id) { (air, error) in
            if(error == ""){
                self.cityResp = air
                self.cityRespFilter = self.cityResp
                self.countryCityTableView.reloadData()
                
            }        }
        
    }
    
}


