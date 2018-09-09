//
//  NotificationsViewController.swift
//  AirBag
//
//  Created by Geek on 8/28/18.
//  Copyright © 2018 Geek. All rights reserved.
//




import UIKit
import JGProgressHUD

protocol ClassAirLineBag: class {
    func AirLineBag(_ airline: String?, _ id : Int?)
}

class AirLinesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var myNavBarItem: UINavigationItem!
    @IBOutlet weak var airlines: UITableView!
    let hud = JGProgressHUD(style: .light)
    var airlinesRes : [Airlines]?
    var departureCityId : Int?
    var airlinesResFiltered : [Airlines]?
     weak var delegateDes: ClassAirLineBag?
     var typeAddEdit : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        customeCenterImage()
        hud.textLabel.text = ConstantStrings.pleaseWait
            self.navigationItem.title = "Choose AirLine"
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       getCountries()
            self.navigationController?.navigationBar.isHidden = false
        searchBar.delegate = self
        
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.airlinesRes != nil){
            
            return (self.airlinesRes?.count)!
            
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "countryCitiesCell", for: indexPath) as! ChooseCtitesTableViewCell
        cell.countryCity.text = self.airlinesRes![indexPath.row].name
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.typeAddEdit == "addBag"){
        delegateDes?.AirLineBag(self.airlinesRes![indexPath.row].name!, self.airlinesRes![indexPath.row].id!)
        }else{
           // delegateDes?.AirLineBag(self.airlinesRes![indexPath.row].name!, self.airlinesRes![indexPath.row].id!)
            editbagAirLineId = self.airlinesRes![indexPath.row].id!
            editbagAirLineName =  self.airlinesRes![indexPath.row].name!
        }

    }
    //MARK: Search Bar/Users/geek/Documents/AirBag/AirBag/Controllers/Carrier/MainAndCreateBag/Airports&Airlines/AirLinesViewController.swift:            editbagAirLineId = self.airlinesRes![indexPath.row].id!
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.airlinesRes = self.airlinesResFiltered?.filter({ animal -> Bool in
            if searchText.isEmpty { return true }
            return animal.name!.lowercased().contains(searchText.lowercased())
        })
        self.airlines.reloadData()
    }
    func getCountries(){
        hud.show(in: self.view)
        GetCountriesCities.GetAirLines { (countries, error) in
            self.hud.dismiss()
            if(error == ""){
                self.airlinesRes = countries
                 self.airlinesResFiltered = self.airlinesRes
                self.airlines.reloadData()
                
            }
        }
        
    }
    @IBAction func dismissBtn(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

