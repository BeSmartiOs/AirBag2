//
//  NAvImage.swift
//  AirBag
//
//  Created by Geek on 8/19/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func customeCenterImage(){
        let image : UIImage = UIImage(named: "them_header.png")!
        //let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 64))
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.appBlue
    }
}
