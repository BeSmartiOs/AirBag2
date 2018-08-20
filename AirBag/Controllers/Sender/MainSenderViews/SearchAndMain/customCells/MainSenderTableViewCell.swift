//
//  MainSenderTableViewCell.swift
//  AirBag
//
//  Created by Geek on 8/20/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit

class MainSenderTableViewCell: UITableViewCell {

    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var seenLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var seenLabelText: UILabel!
    @IBOutlet weak var weightLabelText: UILabel!
    @IBOutlet weak var costLabelText: UILabel!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
