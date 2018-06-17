//
//  Address.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 17/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit
import SwiftyJSON

class Address: NSObject, NSCoding {
    
    var country: String?
    var line1 : String?
    var city : String?
    var status: Int?
    var address_id : Int?
    var zipcode: Int?
    var state: String?
    var user_id: Int?
    var line2: String?
    
    override init () {
        // uncomment this line if your class has been inherited from any other class
        //super.init()
    }
    
    init(address: Address) {
        self.country = address.country
        self.line1 = address.line1
        self.city = address.city
        self.status = address.status
        self.address_id = address.address_id
        self.zipcode = address.zipcode
        self.state = address.state
        self.user_id = address.user_id
        self.line2 = address.line2
    }
    
    init(json: JSON) {
        if json[Constant.c_res_country].type != .null {
            country = json.dictionaryObject![Constant.c_res_country] as! String?
        }
        if json[Constant.c_res_line1].type != .null {
            line1 = json.dictionaryObject![Constant.c_res_line1] as! String?
        }
        if json[Constant.c_res_city].type != .null {
            city = json.dictionaryObject![Constant.c_res_city] as! String?
        }
        if json[Constant.c_res_status].type != .null {
            status = json.dictionaryObject![Constant.c_res_status] as! Int?
        }
        if json[Constant.c_res_id].type != .null {
            address_id = json.dictionaryObject![Constant.c_res_id] as! Int?
        }
        if json[Constant.c_res_zipcode].type != .null {
            zipcode = json.dictionaryObject![Constant.c_res_zipcode] as! Int?
        }
        if json[Constant.c_res_state].type != .null {
            state = json.dictionaryObject![Constant.c_res_state] as! String?
        }
        if json[Constant.c_res_user_id].type != .null {
            user_id = json.dictionaryObject![Constant.c_res_user_id] as! Int?
        }
        if json[Constant.c_res_line2].type != .null {
            line2 = json.dictionaryObject![Constant.c_res_line2] as! String?
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        country = aDecoder.decodeObject(forKey: Constant.c_res_country) as? String
        line1 = aDecoder.decodeObject(forKey: Constant.c_res_line1) as? String
        city = aDecoder.decodeObject(forKey: Constant.c_res_city) as? String
        status = aDecoder.decodeObject(forKey: Constant.c_res_status) as? Int
        address_id = aDecoder.decodeObject(forKey: Constant.c_res_id) as? Int
        zipcode = aDecoder.decodeObject(forKey: Constant.c_res_zipcode) as? Int
        state = aDecoder.decodeObject(forKey: Constant.c_res_state) as? String
        user_id = aDecoder.decodeObject(forKey: Constant.c_res_user_id) as? Int
        line2 = aDecoder.decodeObject(forKey: Constant.c_res_line2) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(country, forKey: Constant.c_res_country)
        aCoder.encode(line1, forKey: Constant.c_res_line1)
        aCoder.encode(city, forKey: Constant.c_res_city)
        aCoder.encode(status, forKey: Constant.c_res_status)
        aCoder.encode(address_id, forKey: Constant.c_res_id)
        aCoder.encode(zipcode, forKey: Constant.c_res_zipcode)
        aCoder.encode(state, forKey: Constant.c_res_state)
        aCoder.encode(user_id, forKey: Constant.c_res_user_id)
        aCoder.encode(line2, forKey: Constant.c_res_line2)
    }
}
