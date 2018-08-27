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
    var bagId = 0
    var categryResponses : [CategoryResp]?
    var choosenCatId = 0
    var choosenCatName = ""
    var choosenItemName = ""
    var choosenItemId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
       getCategories()
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
        if(self.categryResponses != nil ){
            return (self.categryResponses?.count)!
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCitiesCell", for: indexPath) as! ChooseCtitesTableViewCell
        cell.countryCity.text = self.categryResponses![indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.choosenCatName = self.categryResponses![indexPath.row].name!
        self.choosenCatId = self.categryResponses![indexPath.row].id!
        performSegue(withIdentifier: "chooseItemFromCategoty", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "chooseItemFromCategoty"){
            let des = segue.destination as! ChooseItemViewController
            des.choosenCatId = self.choosenCatId
           des.delegate = self
            
            
        }
    }
    
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        if(self.choosenItemId == 0){

        }else{
            choosenItemNameGlobal = self.choosenItemName
            choosenItemIdGlobal = self.choosenItemId
            choosenCategoryNameGlobal = self.choosenCatName
        }
        self.dismiss(animated: false, completion: nil)
    }
    func ChooseItem(_ item: String?, _ id: Int?) {
        self.choosenItemName = item!
        self.choosenItemId = id!
    }
    func getCategories(){
        GetCategories.GetCategoriesParams(bagId: self.bagId) { (catRes, error) in
            if(error == ""){
                
                self.categryResponses = catRes
                self.chooseCategory.reloadData()
            }

        }
    }
}

