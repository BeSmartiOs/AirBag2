//
//  RecieverViewController.swift
//  AirBag
//
//  Created by Geek on 8/29/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit

class RecieverViewController: UITabBarController {

    @IBOutlet weak var recieverTab: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recieverTab.barTintColor = UIColor.appBlue
        self.recieverTab.isTranslucent = false
        self.recieverTab.items?[0].title = ConstantStrings.transactions
        self.recieverTab.items?[0].image = #imageLiteral(resourceName: "order")
        self.recieverTab.items?[1].title = ConstantStrings.menu
        self.recieverTab.items?[1].image = #imageLiteral(resourceName: "menu")
        print(self.view.frame.width)
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        for item in self.recieverTab.items! {
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


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
