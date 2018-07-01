//
//  Customers.swift
//  KCPL
//
//  Created by MacBook Pro on 01/07/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import Foundation
import SwiftyJSON

class Customers: NSObject, NSCoding {
    
    var email: String?
    var address : String?
    var lastName: String?
    var customerId : Int?
    var phone: String?
    var firstName: String?
    
    override init () {
        // uncomment this line if your class has been inherited from any other class
        //super.init()
    }
    
    init(customer: Customers) {
        self.email = customer.email
        self.address = customer.address
        self.lastName = customer.lastName
        self.customerId = customer.customerId
        self.phone = customer.phone
        self.firstName = customer.firstName
    }
    
    init(json: JSON) {
        if json[Constant.c_res_email].type != .null {
            email = json.dictionaryObject![Constant.c_res_email] as! String?
        }
        if json[Constant.c_res_address].type != .null {
            address = json.dictionaryObject![Constant.c_res_address] as! String?
        }
        if json[Constant.c_res_last_name].type != .null {
            lastName = json.dictionaryObject![Constant.c_res_last_name] as! String?
        }
        if json[Constant.c_res_id].type != .null {
            customerId = json.dictionaryObject![Constant.c_res_id] as! Int?
        }
        if json[Constant.c_res_phone].type != .null {
            phone = json.dictionaryObject![Constant.c_res_phone] as! String?
        }
        if json[Constant.c_res_first_name].type != .null {
            firstName = json.dictionaryObject![Constant.c_res_first_name] as! String?
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        email = aDecoder.decodeObject(forKey: Constant.c_res_email) as? String
        address = aDecoder.decodeObject(forKey: Constant.c_res_address) as? String
        lastName = aDecoder.decodeObject(forKey: Constant.c_res_last_name) as? String
        customerId = aDecoder.decodeObject(forKey: Constant.c_res_id) as? Int
        phone = aDecoder.decodeObject(forKey: Constant.c_res_phone) as? String
        firstName = aDecoder.decodeObject(forKey: Constant.c_res_first_name) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(email, forKey: Constant.c_res_email)
        aCoder.encode(address, forKey: Constant.c_res_address)
        aCoder.encode(lastName, forKey: Constant.c_res_last_name)
        aCoder.encode(customerId, forKey: Constant.c_res_id)
        aCoder.encode(phone, forKey: Constant.c_res_phone)
        aCoder.encode(firstName, forKey: Constant.c_res_first_name)
    }
}
