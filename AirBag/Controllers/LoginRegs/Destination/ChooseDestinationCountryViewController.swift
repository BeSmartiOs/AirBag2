//
//  ChooseCountriesViewController.swift
//  AirBag
//
//  Created by Geek on 8/15/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit



//protocol ClassBVCDelegate: class {
//    func chooseCountry(_ country: String?, _ id : Int?)
//}

class ChooseDestinationCountryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,ClassDestinationCity {
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var countryCityTableView: UITableView!
    @IBOutlet weak var myNavBarItem: UINavigationItem!
    // weak var delegate: ClassBVCDelegate?
    var choosenDestinationCountry = ""
    var finalChoosenCity = ""
    var finalChoosenCityId : Int?
    var choosenDestinationCountryId : Int?
    var countriesRes : [CountriesResp]?
    var countriesResFiltered : [CountriesResp]?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
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
        self.choosenDestinationCountry = (self.countriesRes?[indexPath.row].name)!
        self.choosenDestinationCountryId = (self.countriesRes?[indexPath.row].id)!
        performSegue(withIdentifier: "goToDestinationCities", sender: self)
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
        if(segue.identifier == "goToDestinationCities"){
            let des = segue.destination as! ChooseDestinationCityViewController
            des.delegate = self
            des.choosenDestinationCountryId =  self.choosenDestinationCountryId //id of country
            des.currentCountry  =  self.choosenDestinationCountry //title
        }
    }
    
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        if(self.finalChoosenCityId == nil){
            
        }else{
      choosenDestinationFinalCity =  self.finalChoosenCity
        choosenDestinationFinalCountry = self.choosenDestinationCountry
        choosenDestinationFinalCityId = self.finalChoosenCityId!
        }
        self.dismiss(animated: false, completion: nil)
    }
    func ChooseDestinationCity(_ city: String?, _ id: Int?) {
        self.finalChoosenCityId = id
        self.finalChoosenCity = city!
    }
    
    
    
}

