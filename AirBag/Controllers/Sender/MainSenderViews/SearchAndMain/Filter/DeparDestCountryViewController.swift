//
//  ChooseCountriesViewController.swift
//  AirBag
//
//  Created by Geek on 8/15/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit





class DeparDestCountryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,ClassDepartureCityFiltered,ClassDestCityFiltered {
    
    

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
    var cityClass = DeparDestCityViewController()
    var typeOfWay : Int?
    var typeOfClass  : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.countriesResFiltered = self.countriesRes
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        print(typeOfWay ?? 0)
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
         self.departureCountryId = (self.countriesRes?[indexPath.row].id)!
        if(typeOfWay == 3){ //3 departue 4 destination

        DeparCuntryName = (self.countriesRes?[indexPath.row].name)!
        editProfileDepartureCountryName =  (self.countriesRes?[indexPath.row].name)!
        }else if(typeOfWay == 4){
            DestCuntryName = (self.countriesRes?[indexPath.row].name)!
             editProfileDestinationCountryName =  (self.countriesRes?[indexPath.row].name)!
        }else{
            editProfileCountryCityName = (self.countriesRes?[indexPath.row].name)!
        }
        
        performSegue(withIdentifier: "goToCitiesFiltered", sender: self)
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
        if(segue.identifier == "goToCitiesFiltered"){
            let des = segue.destination as! DeparDestCityViewController
            des.departureCountryId = self.departureCountryId
                des.typeOfWay = self.typeOfWay
//            des.currentCountry  =  self.choosenCountry
            des.delegateDes = self
            des.delegateDep = self
            
        }
    }
    
    @IBAction func dismissView(_ sender: UIBarButtonItem) {

        self.navigationController?.popViewController(animated: true)
        
    }
    func DepartureCityFiltered(_ city: String?, _ id: Int?) {
         DeparCityName = city!
         DeparCityId = id!
        
    }
    
    func DestCityFiltered(_ city: String?, _ id: Int?) {
       
         DestCityName = city!
         DestCityId = id!
    }
    
}

