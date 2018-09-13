//
//  ProfilesViewController.swift
//  AirBag
//
//  Created by Geek on 9/10/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit
import JGProgressHUD

class ProfilesViewController: UIViewController {
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var addressText: UILabel!
    @IBOutlet weak var freqTravel: UILabel!
    @IBOutlet weak var favDeparture: UILabel!
    @IBOutlet weak var faveDestination: UILabel!
    @IBOutlet weak var creditText: UILabel!
    @IBOutlet weak var preferedCats: UILabel!
    @IBOutlet weak var editProfile: UIBarButtonItem!
    
    /* 1 -->> coming from sender to view carrier Info*/
    var typeFrom : Int?
    var profileResps : ProfileResponse?
    let hud = JGProgressHUD(style: .light)
    override func viewDidLoad() {
        super.viewDidLoad()
        customeCenterImage()
       hud.textLabel.text = ConstantStrings.pleaseWait
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getProfile()
        if(typeFrom == 1){
            
          self.editProfile.title = ""
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "editUserProfile"){
            let des = segue.destination as! EditProfilesViewController
            des.profileResps = self.profileResps
            
        }
    }
   
    @IBAction func editProfileAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "editUserProfile", sender: self)
    }
    
    func getProfile(){
        hud.show(in: self.view)
        ProfilesApi.GetProfiles { (profileResp, error) in
            if(error == ""){
                self.hud.dismiss()
                self.profileResps = profileResp
                self.viewDetails(details: self.profileResps!)
            }
        }
        
        
    }
    func viewDetails( details: ProfileResponse){
        for detailss in details.basicInfo!{
        self.firstName.text = detailss.firstName
        self.lastName.text = detailss.lastName
        self.email.text = detailss.email
        self.mobile.text = detailss.mobile
        self.city.text = ""
        self.addressText.text = detailss.address
        self.freqTravel.text = detailss.frequentTravelNumber?.description
        self.favDeparture.text = ""
        self.faveDestination.text = ""
        self.creditText.text = detailss.creditCard
       
        }
        for cats in details.preferredCategories!{
            self.preferedCats.text = cats.category
        }

    }
}
