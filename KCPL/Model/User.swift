//
//  User.swift
//  KCPL
//
//  Created by Piyush Sanepara on 29/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: NSObject, NSCoding {
    
    var id : Int?
    var email: String?
    var first_name : String?
    var last_name : String?
    var phone: String?
    var auth_token: String?
    var address: String?
    
    override init () {
        // uncomment this line if your class has been inherited from any other class
        //super.init()
    }
    
    init(json: JSON) {
        if json[Constant.c_res_id].type != .null {
            id = json.dictionaryObject![Constant.c_res_id] as! Int?
        }
        if json[Constant.c_res_email].type != .null {
            email = json.dictionaryObject![Constant.c_res_email] as! String?
        }
        if json[Constant.c_res_first_name].type != .null {
            first_name = json.dictionaryObject![Constant.c_res_first_name] as! String?
        }
        if json[Constant.c_res_last_name].type != .null {
            last_name = json.dictionaryObject![Constant.c_res_last_name] as! String?
        }
        if json[Constant.c_res_phone].type != .null {
            phone = json.dictionaryObject![Constant.c_res_phone] as! String?
        }
        if json[Constant.c_res_auth_token].type != .null {
            auth_token = json.dictionaryObject![Constant.c_res_auth_token] as! String?
        }
        if json[Constant.c_res_address].type != .null {
            address = json.dictionaryObject![Constant.c_res_address] as! String?
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: Constant.c_res_id) as? Int
        email = aDecoder.decodeObject(forKey: Constant.c_res_email) as? String
        first_name = aDecoder.decodeObject(forKey: Constant.c_res_first_name) as? String
        last_name = aDecoder.decodeObject(forKey: Constant.c_res_last_name) as? String
        phone = aDecoder.decodeObject(forKey: Constant.c_res_phone) as? String
        auth_token = aDecoder.decodeObject(forKey: Constant.c_res_auth_token) as? String
        address = aDecoder.decodeObject(forKey: Constant.c_res_address) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: Constant.c_res_id)
        aCoder.encode(email, forKey: Constant.c_res_email)
        aCoder.encode(first_name, forKey: Constant.c_res_first_name)
        aCoder.encode(last_name, forKey: Constant.c_res_last_name)
        aCoder.encode(phone, forKey: Constant.c_res_phone)
        aCoder.encode(auth_token, forKey: Constant.c_res_auth_token)
        aCoder.encode(address, forKey: Constant.c_res_address)
    }
}

