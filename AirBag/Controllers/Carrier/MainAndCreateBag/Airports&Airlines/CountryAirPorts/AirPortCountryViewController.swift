//
//  ChooseCountriesViewController.swift
//  AirBag
//
//  Created by Geek on 8/15/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit





class AirPortCountryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var countryCityTableView: UITableView!
    @IBOutlet weak var myNavBarItem: UINavigationItem!
    var choosenCity = ""
    var choosenCountry = ""
    var countriesRes : [CountriesResp]?
    var countriesResFiltered : [CountriesResp]?
    var departureCityId : Int?
    var departureCountryId : Int?
    var airPortWay : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
       // self.navigationController?.navigationBar.isHidden = true
        self.countriesResFiltered = self.countriesRes
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        myNavBarItem.title = ConstantStrings.countries
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.countriesRes != nil){
            return (self.countriesRes?.count)!
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCitiesCell", for: indexPath) as! ChooseCtitesTableViewCell
        cell.countryCity.text = self.countriesRes?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // tableView.deselectRow(at: indexPath, animated: true)
        if(airPortWay == 1){

             bagAirDepartureCountryName = (self.countriesRes?[indexPath.row].name)!
            
           
        }else{
           
             bagAirDestinationCountryName = (self.countriesRes?[indexPath.row].name)!
        }
        
        self.choosenCountry = (self.countriesRes?[indexPath.row].name)!
        self.departureCountryId = (self.countriesRes?[indexPath.row].id)!
        performSegue(withIdentifier: "goToCitiesBag", sender: self)
    }
    
    
    
    //MARK: Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.countriesRes = self.countriesResFiltered?.filter({ animal -> Bool in
            if searchText.isEmpty { return true }
            return animal.name!.lowercased().contains(searchText.lowercased())
        })
        self.countryCityTableView.reloadData()
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToCitiesBag"){
            let des = segue.destination as! AirPortCityViewController
            des.departureCountryId = self.departureCountryId
            des.currentCountry  =  self.choosenCountry
           des.airPortWay = self.airPortWay
            
        }
    }
    
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
       self.navigationController?.popViewController(animated: true)
    }
    
    
}

