//
//  FilterViewController.swift
//  AirBag
//
//  Created by Geek on 8/28/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    
    var isTableVisible = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableHeight.constant = 0
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "userType")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "userType")
        }
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.text = "jj"
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
//        chooseUsersBtn.setTitle("User Selected: \(types[indexPath.row].typeString!)", for: .normal)
//        UIView.animate(withDuration: 0.5) {
//            self.tableViewHeight.constant = 0
//            self.isTableVisible = false
//            self.view.layoutIfNeeded()
//        }
//        print(self.userType)
        
    }


    @IBAction func choseAirLine(_ sender: Any) {
    }
    
    
    @IBAction func choseCarrier(_ sender: Any) {
    }
    @IBAction func choseDeparture(_ sender: Any) {
    }
    @IBAction func choseDestination(_ sender: Any) {
    }
    @IBAction func choseCategory(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            if self.isTableVisible == false {
                self.isTableVisible = true
                self.tableHeight.constant = 44.0 * 3.0
            } else {
                self.tableHeight.constant = 0
                self.isTableVisible = false
            }
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func Filter(_ sender: Any) {
    }
    @IBAction func Reset(_ sender: Any) {
    }
}
