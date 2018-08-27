//
//  TransactionItemsTableViewController.swift
//  AirBag
//
//  Created by Geek on 8/26/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit

class TransactionItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var peice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
