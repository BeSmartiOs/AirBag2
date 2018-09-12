//
//  DeparDestCityViewController.swift
//  AirBag
//
//  Created by Geek on 8/28/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit
import JGProgressHUD
    

    protocol ClassDepartureCityFiltered: class {
        func DepartureCityFiltered(_ city: String?, _ id : Int?)
    }
    protocol ClassDestCityFiltered: class {
        func DestCityFiltered(_ city: String?, _ id : Int?)
    }
    class DeparDestCityViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate  {

        @IBOutlet weak var searchBar: UISearchBar!
        @IBOutlet weak var myNavBarItem: UINavigationItem!
        @IBOutlet weak var myNavigationBar: UINavigationBar!
        @IBOutlet weak var countryCityTableView: UITableView!
        weak var delegateDep: ClassDepartureCityFiltered?
         weak var delegateDes: ClassDestCityFiltered?
        var currentCountry = ""
        var departureCityId : Int?
        var departureCountryId : Int?
        var cityResp : [CountriesResp]?
         var cityResFiltered : [CountriesResp]?
        var typeOfWay : Int?
         let hud  = JGProgressHUD(style: .light)
        override func viewDidLoad() {
            super.viewDidLoad()
            self.myNavBarItem.title = self.currentCountry
             hud.textLabel.text = ConstantStrings.pleaseWait
             searchBar.delegate = self
            
            // Do any additional setup after loading the view.
        }
        override func viewWillAppear(_ animated: Bool) {
            if(typeOfWay == 3){
                self.myNavBarItem.title = DeparCuntryName
            }else{
                 self.myNavBarItem.title = DestCuntryName
            }
            
            self.getCities(id: self.departureCountryId!)
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
            if(typeOfWay == 3){
                  self.delegateDep?.DepartureCityFiltered(self.cityResp?[indexPath.row].name, self.cityResp?[indexPath.row].id)
                
                editProfileDepartureName = self.cityResp?[indexPath.row].name
                editProfileDepartureId = self.cityResp?[indexPath.row].id
            }else  if(typeOfWay == 4){
                 self.delegateDes?.DestCityFiltered(self.cityResp?[indexPath.row].name, self.cityResp?[indexPath.row].id)
                
                editProfileDestinationame = self.cityResp?[indexPath.row].name
                editProfileDestinationId = self.cityResp?[indexPath.row].id
            }else{
                editProfileCityName = self.cityResp?[indexPath.row].name
                editProfileCityId = self.cityResp?[indexPath.row].id
            }
          
        }
        //MARK: Search Bar
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.cityResp = self.cityResFiltered?.filter({ animal -> Bool in
                if searchText.isEmpty { return true }
                return animal.name!.lowercased().contains(searchText.lowercased())
            })
            self.countryCityTableView.reloadData()
        }
        
        @IBAction func dismissView(_ sender: UIBarButtonItem) {
            self.navigationController?.popViewController(animated: true)
            
        }
        
        func getCities(id :Int){
              hud.show(in: self.view)
            GetCountriesCities.GetCities(id: id) { (cities, error) in
                
                if(error == ""){
                    self.hud.dismiss()
                    self.cityResp = cities
                   self.cityResFiltered  = self.cityResp
                self.countryCityTableView.reloadData()
                    
                }else{
                    self.hud.dismiss()
                }
                self.hud.dismiss()
            }
            
        }
        
}
