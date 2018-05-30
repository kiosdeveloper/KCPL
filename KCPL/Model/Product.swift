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
    var tax: String?
    var price: String?
    
    override init () {
        // uncomment this line if your class has been inherited from any other class
        //super.init()
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
            tax = json.dictionaryObject![Constant.c_res_tax] as! String?
        }
        if json[Constant.c_res_price].type != .null {
            price = json.dictionaryObject![Constant.c_res_price] as! String?
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: Constant.c_res_id) as? Int
        name = aDecoder.decodeObject(forKey: Constant.c_res_name) as? String
        descriptionProduct = aDecoder.decodeObject(forKey: Constant.c_res_description) as? String
        brand_name = aDecoder.decodeObject(forKey: Constant.c_res_brand_name) as? String
        tax = aDecoder.decodeObject(forKey: Constant.c_res_tax) as? String
        price = aDecoder.decodeObject(forKey: Constant.c_res_price) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: Constant.c_res_id)
        aCoder.encode(name, forKey: Constant.c_res_name)
        aCoder.encode(descriptionProduct, forKey: Constant.c_res_description)
        aCoder.encode(brand_name, forKey: Constant.c_res_brand_name)
        aCoder.encode(tax, forKey: Constant.c_res_tax)
        aCoder.encode(price, forKey: Constant.c_res_price)
    }
}
