//
//  ChooseCountriesViewController.swift
//  AirBag
//
//  Created by Geek on 8/15/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit





class ChooseCountriesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,ClassDepartureCity,UISearchBarDelegate {
   
   
    
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
    var cityClass = ChooseCityViewController()
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
            tableView.deselectRow(at: indexPath, animated: true)
        self.choosenCountry = (self.countriesRes?[indexPath.row].name)!
        self.departureCountryId = (self.countriesRes?[indexPath.row].id)!
       performSegue(withIdentifier: "goToCities", sender: self)
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
        if(segue.identifier == "goToCities"){
            let des = segue.destination as! ChooseCityViewController
            des.departureCountryId = self.departureCountryId
            des.currentCountry  =  self.choosenCountry
            des.delegate = self
           
        }
    }
    
        @IBAction func dismissView(_ sender: UIBarButtonItem) {
            if(self.departureCityId == nil){
                
            }else{
             choosenDepartureFinalCity =  self.choosenCity
            choosenDepartureFinalCountry = self.choosenCountry
            choosenDepartureFinalCityId = self.departureCityId!
            }
            self.dismiss(animated: false, completion: nil)
        }
    func chooseDepartureCity(_ city: String?, _ id: Int?) {
        self.choosenCity = city!
        self.departureCityId = id
    }
    
}
