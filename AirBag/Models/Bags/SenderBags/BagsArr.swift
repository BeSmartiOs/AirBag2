//
//  BagsArr.swift
//  AirBag
//
//  Created by Geek on 8/26/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import Foundation

class BagsArr : NSObject{
    
    var availableFeaturedBags : [AvailableFeaturedBag]?
    var availableNormalBags : [AvailableNormalBag]?
    
    
    
    
  
    init(availableFeaturedBags : [AvailableFeaturedBag], availableNormalBags : [AvailableNormalBag]) {
        self.availableFeaturedBags = availableFeaturedBags
        self.availableNormalBags = availableNormalBags
}
}
