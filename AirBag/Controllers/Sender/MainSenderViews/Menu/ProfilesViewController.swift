//
//  ProfilesViewController.swift
//  AirBag
//
//  Created by Geek on 9/10/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit

class ProfilesViewController: UIViewController {
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var freqTravel: UILabel!
    @IBOutlet weak var favDeparture: UILabel!
    @IBOutlet weak var faveDestination: UILabel!
    @IBOutlet weak var credit: UILabel!
    @IBOutlet weak var preferedCats: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        customeCenterImage()
        // Do any additional setup after loading the view.
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

}
