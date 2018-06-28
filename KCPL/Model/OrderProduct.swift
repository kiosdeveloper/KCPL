//
//  OrderProduct.swift
//  KCPL
//
//  Created by MacBook Pro on 29/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrderProduct: NSObject, NSCoding {
    
    var name: String?
    var order_id : Int?
    var qty: Int?
    var tax : Double?
    var price: Int?
    var product_id: Int?
    var image_url: String?
    
    override init () {
        // uncomment this line if your class has been inherited from any other class
        //super.init()
    }
    
    init(product: OrderProduct) {
        self.name = product.name
        self.order_id = product.order_id
        self.qty = product.qty
        self.tax = product.tax
        self.price = product.price
        self.product_id = product.product_id
        self.image_url = product.image_url
    }
    
    init(json: JSON) {
        if json[Constant.c_res_name].type != .null {
            name = json.dictionaryObject![Constant.c_res_name] as! String?
        }
        if json[Constant.c_res_order_id].type != .null {
            order_id = json.dictionaryObject![Constant.c_res_order_id] as! Int?
        }
        if json[Constant.c_res_qty].type != .null {
            qty = json.dictionaryObject![Constant.c_res_qty] as! Int?
        }
        if json[Constant.c_res_tax].type != .null {
            tax = json.dictionaryObject![Constant.c_res_tax] as! Double?
        }
        if json[Constant.c_res_price].type != .null {
            price = json.dictionaryObject![Constant.c_res_price] as! Int?
        }
        if json[Constant.c_res_product_id].type != .null {
            product_id = json.dictionaryObject![Constant.c_res_product_id] as! Int?
        }
        if json[Constant.c_res_image_url].type != .null {
            image_url = json.dictionaryObject![Constant.c_res_image_url] as! String?
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: Constant.c_res_confirmation_date) as? String
        order_id = aDecoder.decodeObject(forKey: Constant.c_res_order_id) as? Int
        qty = aDecoder.decodeObject(forKey: Constant.c_res_qty) as? Int
        tax = aDecoder.decodeObject(forKey: Constant.c_res_tax) as? Double
        price = aDecoder.decodeObject(forKey: Constant.c_res_price) as? Int
        product_id = aDecoder.decodeObject(forKey: Constant.c_res_product_id) as? Int
        image_url = aDecoder.decodeObject(forKey: Constant.c_res_image_url) as? String
    
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Constant.c_res_confirmation_date)
        aCoder.encode(order_id, forKey: Constant.c_res_order_id)
        aCoder.encode(qty, forKey: Constant.c_res_qty)
        aCoder.encode(tax, forKey: Constant.c_res_tax)
        aCoder.encode(price, forKey: Constant.c_res_price)
        aCoder.encode(product_id, forKey: Constant.c_res_product_id)
        aCoder.encode(image_url, forKey: Constant.c_res_image_url)
    }
}
