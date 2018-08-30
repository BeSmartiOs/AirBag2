//
//  ChooseCityViewController.swift
//  AirBag
//
//  Created by Geek on 8/15/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit



class AirPortCityViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate  {

    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var myNavBarItem: UINavigationItem!
    @IBOutlet weak var myNavigationBar: UINavigationBar!
    @IBOutlet weak var countryCityTableView: UITableView!
    var currentCountry = ""
    var departureCityId : Int?
    var departureCountryId : Int?
    var cityResp : [CountriesResp]?
    var cityRespFilter : [CountriesResp]?
     var airPortWay : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
       //  self.navigationController?.navigationBar.isHidden = true
        self.myNavBarItem.title = self.currentCountry
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
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
    self.departureCityId = self.cityResp?[indexPath.row].id
        performSegue(withIdentifier: "goToCitiesAirports", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToCitiesAirports"){
            let des = segue.destination as! AirPortssViewController
            des.departureCityId = self.departureCityId
          des.airPortWay = self.airPortWay
            
            
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
    func getCities(id :Int){
        GetCountriesCities.GetCities(id: id) { (cities, error) in
            if(error == ""){
                self.cityResp = cities
                self.cityRespFilter = self.cityResp
                self.countryCityTableView.reloadData()
                
            }
        }
        
    }
    
}

