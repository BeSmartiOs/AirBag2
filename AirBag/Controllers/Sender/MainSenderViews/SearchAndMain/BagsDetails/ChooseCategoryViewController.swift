//
//  ChooseCountriesViewController.swift
//  AirBag
//
//  Created by Geek on 8/15/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit





class ChooseCategoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,ChooseItemClass {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var chooseCategory: UITableView!
    @IBOutlet weak var myNavBarItem: UINavigationItem!
    var cityClass = ChooseItemViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "chooseItemFromCategoty", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "chooseItemFromCategoty"){
            let des = segue.destination as! ChooseItemViewController
//            des.departureCountryId = self.departureCountryId
//            des.currentCountry  =  self.choosenCountry
           des.delegate = self
            
            
        }
    }
    
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
//        if(self.departureCityId == nil){
//
//        }else{
//            choosenDepartureFinalCity =  self.choosenCity
//            choosenDepartureFinalCountry = self.choosenCountry
//            choosenDepartureFinalCityId = self.departureCityId!
        //}
        self.dismiss(animated: false, completion: nil)
    }
    func ChooseItem(_ item: String?, _ id: Int?) {
//        self.choosenCity = city!
//        self.departureCityId = id
    }
    
}

