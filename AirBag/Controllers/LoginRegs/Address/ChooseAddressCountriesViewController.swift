//
//  ChooseCountriesViewController.swift
//  AirBag
//
//  Created by Geek on 8/15/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit



protocol classPhoneCode: class {
    func ChoosePhoneCode(_ phoneCode: String?)
    
}
class ChooseAddressCountriesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,ClassAddressCity{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var countryCityTableView: UITableView!
    @IBOutlet weak var myNavBarItem: UINavigationItem!
    // weak var delegate: ClassBVCDelegate?
    var choosenCountry = ""
    var choosenCountryId : Int?
    weak var delegatePhone : classPhoneCode?
    var choosenAddressCity = ""
    var choosenAddressCityId : Int?
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
        self.choosenCountry = (self.countriesRes?[indexPath.row].name)!
       self.choosenCountryId = (self.countriesRes?[indexPath.row].id)!
         self.delegatePhone?.ChoosePhoneCode(self.countriesRes?[indexPath.row].phoneCode)
        performSegue(withIdentifier: "goToAddressCity", sender: self)
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
        if(segue.identifier == "goToAddressCity"){
            let des = segue.destination as! ChooseAddressCityViewController
           des.delegate = self
            des.currentCountry  =  self.choosenCountry
            des.choosenAddressCountryId = self.choosenCountryId
        }
    }
    
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        if(self.choosenAddressCityId == nil){
            
        }else{
        choosenAddressFinalCity = self.choosenAddressCity
        choosenAddressFinalCityId =  self.choosenAddressCityId!
        choosenAddressFinalCountry = self.choosenCountry
        }
        self.dismiss(animated: false, completion: nil)
    }
    func ChooseAddressCity(_ city: String?, _ id: Int?) {
        self.choosenAddressCity = city!
        self.choosenAddressCityId = id
    }
}


