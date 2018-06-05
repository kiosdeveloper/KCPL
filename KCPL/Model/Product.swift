//
//  Product.swift
//  KCPL
//
//  Created by Piyush Sanepara on 30/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit
import SwiftyJSON

class Product: NSObject, NSCoding {
    
    var id : Int?
    var name: String?
    var descriptionProduct : String?
    var brand_name : String?
    var tax: Double?
    var price: Int?
    var quantity: Int?
    var imageUrl: String?
    
    override init () {
        // uncomment this line if your class has been inherited from any other class
        //super.init()
    }
    
    init(product: Product, quantity: Int) {
        self.id = product.id
        self.name = product.name
        self.descriptionProduct = product.descriptionProduct
        self.brand_name = product.brand_name
        self.tax = product.tax
        self.price = product.price
        self.quantity = quantity
        self.imageUrl = product.imageUrl
    }
    
    init(json: JSON) {
        if json[Constant.c_res_id].type != .null {
            id = json.dictionaryObject![Constant.c_res_id] as! Int?
        }
        if json[Constant.c_res_name].type != .null {
            name = json.dictionaryObject![Constant.c_res_name] as! String?
        }
        if json[Constant.c_res_description].type != .null {
            descriptionProduct = json.dictionaryObject![Constant.c_res_description] as! String?
        }
        if json[Constant.c_res_brand_name].type != .null {
            brand_name = json.dictionaryObject![Constant.c_res_brand_name] as! String?
        }
        if json[Constant.c_res_tax].type != .null {
            tax = json.dictionaryObject![Constant.c_res_tax] as! Double?
        }
        if json[Constant.c_res_price].type != .null {
            price = json.dictionaryObject![Constant.c_res_price] as! Int?
        }
        if json[Constant.c_res_image_url].type != .null {
            imageUrl = json.dictionaryObject![Constant.c_res_image_url] as! String?
        }
        quantity = 0
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: Constant.c_res_id) as? Int
        name = aDecoder.decodeObject(forKey: Constant.c_res_name) as? String
        descriptionProduct = aDecoder.decodeObject(forKey: Constant.c_res_description) as? String
        brand_name = aDecoder.decodeObject(forKey: Constant.c_res_brand_name) as? String
        tax = aDecoder.decodeObject(forKey: Constant.c_res_tax) as? Double
        price = aDecoder.decodeObject(forKey: Constant.c_res_price) as? Int
        imageUrl = aDecoder.decodeObject(forKey: Constant.c_res_image_url) as? String
        quantity = aDecoder.decodeObject(forKey: Constant.c_res_quantity) as? Int
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: Constant.c_res_id)
        aCoder.encode(name, forKey: Constant.c_res_name)
        aCoder.encode(descriptionProduct, forKey: Constant.c_res_description)
        aCoder.encode(brand_name, forKey: Constant.c_res_brand_name)
        aCoder.encode(tax, forKey: Constant.c_res_tax)
        aCoder.encode(price, forKey: Constant.c_res_price)
        aCoder.encode(imageUrl, forKey: Constant.c_res_image_url)
        aCoder.encode(quantity, forKey: Constant.c_res_quantity)
    }
}
