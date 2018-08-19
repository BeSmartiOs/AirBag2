//
//  LoginsViewController.swift
//  AirBag
//
//  Created by Geek on 8/15/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit
import JGProgressHUD
class LoginsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    

    //MARK:- Outlets
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var dontHaveAccount: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var emaiTextFeild: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var chooseUsersBtn: UIButton!
    
    var isTableVisible = false
    var types = [UserTypes]()
    var userType = 0
    var loginResp : LoginResponse?
    let hud = JGProgressHUD(style: .light)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text = ConstantStrings.pleaseWait
        self.navigationController?.navigationBar.isHidden = true
        types = [UserTypes(typeString: ConstantStrings.carrier, typeInt: Constants.UserType.carrier),UserTypes(typeString: ConstantStrings.sender, typeInt: Constants.UserType.sender),UserTypes(typeString: ConstantStrings.reciever, typeInt: Constants.UserType.reciever)]
        tableViewHeight.constant = 0
        setUpView()
        usersTableView.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidDisappear(_ animated: Bool) {
          self.navigationController?.navigationBar.isHidden = false
    }
    @IBAction func chooseUserType(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            if self.isTableVisible == false {
                self.isTableVisible = true
                self.tableViewHeight.constant = 44.0 * 3.0
            } else {
                self.tableViewHeight.constant = 0
                self.isTableVisible = false
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func login(_ sender: Any) {
        if(AbstractViewController.validateLogin(userType: self.userType, email: self.emaiTextFeild.text!, password: self.passwordTextFeild.text!)){
            
            if(AbstractViewController.isValidEmail(testStr: self.emaiTextFeild.text!)){
                self.login(email: self.emaiTextFeild.text!, password: self.passwordTextFeild.text!, userType: self.userType)
                
            }else{
                 self.creatAlert(tite: ConstantStrings.emailVAid)
            }
            
        }else{
            self.creatAlert(tite: ConstantStrings.pleaseFillRequired)
        }
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        performSegue(withIdentifier: "goToRegisteration", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "goToRegisteration"){
            let destination = segue.destination as! RegisterationViewController
            destination.title = ConstantStrings.registerationTitle
            
            
        }
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "userType")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "userType")
        }
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.text = types[indexPath.row].typeString
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.userType = types[indexPath.row].typeInt!
        chooseUsersBtn.setTitle("User Selected: \(types[indexPath.row].typeString!)", for: .normal)
        UIView.animate(withDuration: 0.5) {
            self.tableViewHeight.constant = 0
            self.isTableVisible = false
            self.view.layoutIfNeeded()
        }
        print(self.userType)
        
    }

    func setUpView(){
        self.emailLabel.text = ConstantStrings.emailLabel
        self.emaiTextFeild.placeholder = ConstantStrings.emailLabel
        self.passwordLabel.text = ConstantStrings.passwordLabel
        self.passwordTextFeild.placeholder = ConstantStrings.passwordLabel
        self.chooseUsersBtn.setTitle(ConstantStrings.chooseUser, for: .normal)
        self.loginBtn.setTitle(ConstantStrings.login, for: .normal)
        self.signUpBtn.setTitle(ConstantStrings.register, for: .normal)
        self.dontHaveAccount.text = ConstantStrings.dontHaveAccout
    }
    func creatAlert(tite : String){
        // create the alert
        let alert = UIAlertController(title: tite, message: "", preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func login(email : String, password : String, userType : Int){
        self.hud.show(in: self.view)
        LoginApi.LoginApi(email: email, currentTypeId: userType, password: password) { (logResp, error) in
            if(error == ""){
                self.hud.dismiss()
                self.loginResp = logResp
                let userDefaults = UserDefaults.standard
                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.loginResp)
                userDefaults.set(encodedData, forKey: "logResp")
                userDefaults.synchronize()
            }else{
                self.hud.dismiss()
            }
        }
    }
}
