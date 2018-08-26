//
//  BagItems.swift
//  AirBag
//
//  Created by Geek on 8/26/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import Foundation
class BagItems : NSObject,NSCoding{
   
    var width : Double?
    var height : Double?
    var weight : Double?
    var length : Double?
    var descripItem : String?
    var imageString : String?
    var newCategories : String?
    var recieverId : Int?
    var itemId : Int?
    var bagId : Int?
    
    init(width : Double,height : Double,weight : Double,length : Double,descripItem : String,imageString : String,newCategories : String,recieverId : Int,itemId : Int,bagId : Int) {
        self.width = width
        self.height = height
        self.weight = weight
        self.length = length
        self.descripItem = descripItem
        self.imageString = imageString
        self.newCategories = newCategories
        self.recieverId = recieverId
        self.itemId = itemId
        self.bagId = bagId
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        width = aDecoder.decodeObject(forKey: "width") as? Double
        height = aDecoder.decodeObject(forKey: "height") as? Double
        weight = aDecoder.decodeObject(forKey: "weight") as? Double
        length = aDecoder.decodeObject(forKey: "length") as? Double
        descripItem = aDecoder.decodeObject(forKey: "descripItem") as? String
        imageString = aDecoder.decodeObject(forKey: "imageString") as? String
        newCategories = aDecoder.decodeObject(forKey: "newCategories") as? String
        recieverId = aDecoder.decodeObject(forKey: "recieverId") as? Int
         itemId = aDecoder.decodeObject(forKey: "itemId") as? Int
        bagId = aDecoder.decodeObject(forKey: "bagId") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if width != nil{
            aCoder.encode(width, forKey: "width")
        }
        if height != nil{
            aCoder.encode(height, forKey: "height")
        }
        if weight != nil{
            aCoder.encode(weight, forKey: "weight")
        }
        if length != nil{
            aCoder.encode(length, forKey: "length")
        }
        if descripItem != nil{
            aCoder.encode(descripItem, forKey: "descripItem")
        }
        if imageString != nil{
            aCoder.encode(imageString, forKey: "imageString")
        }
        if newCategories != nil{
            aCoder.encode(newCategories, forKey: "newCategories")
        }
        if recieverId != nil{
            aCoder.encode(recieverId, forKey: "recieverId")
        }
        if itemId != nil{
            aCoder.encode(itemId, forKey: "itemId")
        }
        if bagId != nil{
            aCoder.encode(bagId, forKey: "bagId")
        }
    }
    
}


