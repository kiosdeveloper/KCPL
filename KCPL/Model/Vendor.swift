//
//  Vendor.swift
//  KCPL
//
//  Created by Piyush Sanepara on 10/07/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import Foundation
import SwiftyJSON

class Vendor: NSObject, NSCoding {
    
    var email: String?
    var address : String?
    var address_line_1 : String?
    var address_line_2 : String?
    var lastName: String?
    var vendorId : Int?
    var phone_no: String?
    var firstName: String?
    var name: String?
    
    override init () {
        // uncomment this line if your class has been inherited from any other class
        //super.init()
    }
    
    init(vendor: Vendor) {
        self.email = vendor.email
        self.address = vendor.address
        self.address_line_1 = vendor.address_line_1
        self.address_line_2 = vendor.address_line_2
        self.lastName = vendor.lastName
        self.vendorId = vendor.vendorId
        self.phone_no = vendor.phone_no
        self.firstName = vendor.firstName
        self.name = vendor.name
    }
    
    init(json: JSON) {
        if json[Constant.c_res_email].type != .null {
            email = json.dictionaryObject![Constant.c_res_email] as! String?
        }
        if json[Constant.c_res_address].type != .null {
            address = json.dictionaryObject![Constant.c_res_address] as! String?
        }
        if json[Constant.c_res_address_line_1].type != .null {
            address_line_1 = json.dictionaryObject![Constant.c_res_address_line_1] as! String?
        }
        if json[Constant.c_res_address_line_2].type != .null {
            address_line_2 = json.dictionaryObject![Constant.c_res_address_line_2] as! String?
        }
        if json[Constant.c_res_last_name].type != .null {
            lastName = json.dictionaryObject![Constant.c_res_last_name] as! String?
        }
        if json[Constant.c_res_id].type != .null {
            vendorId = json.dictionaryObject![Constant.c_res_id] as! Int?
        }
        if json[Constant.c_res_phone_no].type != .null {
            phone_no = json.dictionaryObject![Constant.c_res_phone_no] as! String?
        }
        if json[Constant.c_res_first_name].type != .null {
            firstName = json.dictionaryObject![Constant.c_res_first_name] as! String?
        }
        if json[Constant.c_res_name].type != .null {
            name = json.dictionaryObject![Constant.c_res_name] as! String?
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        email = aDecoder.decodeObject(forKey: Constant.c_res_email) as? String
        address = aDecoder.decodeObject(forKey: Constant.c_res_address) as? String
        address_line_1 = aDecoder.decodeObject(forKey: Constant.c_res_address_line_1) as? String
        address_line_2 = aDecoder.decodeObject(forKey: Constant.c_res_address_line_2) as? String
        lastName = aDecoder.decodeObject(forKey: Constant.c_res_last_name) as? String
        vendorId = aDecoder.decodeObject(forKey: Constant.c_res_id) as? Int
        phone_no = aDecoder.decodeObject(forKey: Constant.c_res_phone_no) as? String
        firstName = aDecoder.decodeObject(forKey: Constant.c_res_first_name) as? String
        name = aDecoder.decodeObject(forKey: Constant.c_res_name) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(email, forKey: Constant.c_res_email)
        aCoder.encode(address, forKey: Constant.c_res_address)
        aCoder.encode(address_line_1, forKey: Constant.c_res_address_line_1)
        aCoder.encode(address_line_2, forKey: Constant.c_res_address_line_2)
        aCoder.encode(lastName, forKey: Constant.c_res_last_name)
        aCoder.encode(vendorId, forKey: Constant.c_res_id)
        aCoder.encode(phone_no, forKey: Constant.c_res_phone_no)
        aCoder.encode(firstName, forKey: Constant.c_res_first_name)
        aCoder.encode(name, forKey: Constant.c_res_name)
    }
}
