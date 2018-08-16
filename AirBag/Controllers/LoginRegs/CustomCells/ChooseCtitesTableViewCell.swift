//
//  ChooseCtitesTableViewCell.swift
//  AirBag
//
//  Created by Geek on 8/15/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit

class ChooseCtitesTableViewCell: UITableViewCell {

   

    @IBOutlet weak var countryCity: UILabel!
    
    @IBOutlet weak var countrySelected: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
