//
//  ItemsTableViewCell.swift
//  AirBag
//
//  Created by Geek on 8/27/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var carrierName: UILabel!
    @IBOutlet weak var deleteItem: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
