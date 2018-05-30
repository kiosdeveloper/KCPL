//
//  Category.swift
//  KCPL
//
//  Created by Piyush Sanepara on 30/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit
import SwiftyJSON

class Category: NSObject, NSCoding {
    
    var id : Int?
    var name: String?
    var image : String?
    
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
        if json[Constant.c_res_image].type != .null {
            image = json.dictionaryObject![Constant.c_res_image] as! String?
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: Constant.c_res_id) as? Int
        name = aDecoder.decodeObject(forKey: Constant.c_res_name) as? String
        image = aDecoder.decodeObject(forKey: Constant.c_res_image) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: Constant.c_res_id)
        aCoder.encode(name, forKey: Constant.c_res_name)
        aCoder.encode(image, forKey: Constant.c_res_image)
    }
}
