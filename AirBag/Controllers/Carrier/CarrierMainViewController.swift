//
//  CarrierMainViewController.swift
//  AirBag
//
//  Created by Geek on 8/30/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit

class CarrierMainViewController: UITabBarController {
 @IBOutlet weak var CarrierTab: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CarrierTab.barTintColor = UIColor.appBlue
        self.CarrierTab.isTranslucent = false
        self.CarrierTab.items?[0].title = ConstantStrings.airBAg
        self.CarrierTab.items?[0].image = #imageLiteral(resourceName: "airPackage")
        self.CarrierTab.items?[1].title = ConstantStrings.transactions
        self.CarrierTab.items?[1].image = #imageLiteral(resourceName: "order")
        self.CarrierTab.items?[2].title = ConstantStrings.pendingTab
        self.CarrierTab.items?[2].image = #imageLiteral(resourceName: "time-left")
        self.CarrierTab.items?[3].title = ConstantStrings.menu
        self.CarrierTab.items?[3].image = #imageLiteral(resourceName: "menu")
        print(self.view.frame.width)
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        for item in self.CarrierTab.items! {
            let unselectedItem = [NSAttributedStringKey.foregroundColor: UIColor.appGray]
            let selectedItem = [NSAttributedStringKey.foregroundColor: UIColor.white]
            item.setTitleTextAttributes(unselectedItem, for: .normal)
            item.setTitleTextAttributes(selectedItem, for: .selected)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
