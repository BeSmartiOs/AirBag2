//
//  SenderViewController.swift
//  AirBag
//
//  Created by Geek on 8/19/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit

class SenderViewController: UITabBarController {

    @IBOutlet weak var mainTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTabBar.barTintColor = UIColor.appBlue
        self.mainTabBar.isTranslucent = false
        self.mainTabBar.items?[0].title = ConstantStrings.main
        self.mainTabBar.items?[0].image = #imageLiteral(resourceName: "magnifier-tool")
        self.mainTabBar.items?[1].title = ConstantStrings.reservation
        self.mainTabBar.items?[1].image = #imageLiteral(resourceName: "online-booking")
        self.mainTabBar.items?[2].title =   ConstantStrings.menu
        self.mainTabBar.items?[2].image = #imageLiteral(resourceName: "menu")

       print(self.view.frame.width)
        
        // Do any additional setup after loading the view.
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        for item in self.mainTabBar.items! {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func customeCenterImage(){
        let image : UIImage = UIImage(named: "footer.png")!
        let imageView = UIImageView(frame: CGRect(x: 30, y:30, width: self.view.frame.width, height: 49))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.mainTabBar.backgroundImage = imageView.image
    }
}
