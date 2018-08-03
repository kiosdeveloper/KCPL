//
//  Quatations.swift
//  KCPL
//
//  Created by MacBook Pro on 08/07/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit
import SwiftyJSON

class Quatations: NSObject, NSCoding {
    
    var user: User?
    var confirmationDate: String?
    var expectedDeliveryDate : String?
    var invoiceNo: String?
    var shipByAddress : String?
    var status: Int?
    var quatationId: Int?
    var trackingId : Any?
    var createdAt: String?
    var saleById: Int?
    var billToAddress: String?
    var carrierId: Int?
    var userId: Int?
    var shipToAddress: String?
    var products = [OrderProduct]()
    
    override init () {
        // uncomment this line if your class has been inherited from any other class
        //super.init()
    }
    
    init(quatation: Quatations) {
        self.user = quatation.user
        self.confirmationDate = quatation.confirmationDate
        self.expectedDeliveryDate = quatation.expectedDeliveryDate
        self.invoiceNo = quatation.invoiceNo
        self.products = quatation.products
        self.shipByAddress = quatation.shipByAddress
        self.status = quatation.status
        self.quatationId = quatation.quatationId
        self.trackingId = quatation.trackingId
        self.createdAt = quatation.createdAt
        self.saleById = quatation.saleById
        self.billToAddress = quatation.billToAddress
        self.carrierId = quatation.carrierId
        self.userId = quatation.userId
        self.shipToAddress = quatation.shipToAddress
        
    }
    
    init(json: JSON) {
        super.init()
        if json[Constant.c_res_user].type != .null {
            user = self.processUser(json: json[Constant.c_res_user])
        }
        if json[Constant.c_res_confirmation_date].type != .null {
            confirmationDate = json.dictionaryObject![Constant.c_res_confirmation_date] as! String?
        }
        if json[Constant.c_res_expected_delivery_date].type != .null {
            expectedDeliveryDate = json.dictionaryObject![Constant.c_res_expected_delivery_date] as! String?
        }
        if json[Constant.c_res_invoice_no].type != .null {
            invoiceNo = json.dictionaryObject![Constant.c_res_invoice_no] as! String?
        }
        if json[Constant.c_res_ship_by_address].type != .null {
            shipByAddress = json.dictionaryObject![Constant.c_res_ship_by_address] as! String?
        }
        if json[Constant.c_res_status].type != .null {
            status = json.dictionaryObject![Constant.c_res_status] as! Int?
        }
        if json[Constant.c_res_id].type != .null {
            quatationId = json.dictionaryObject![Constant.c_res_id] as! Int?
        }
        if json[Constant.c_res_tracking_id].type != .null {
            //            if Util.isSalesApp() || Util.isAdminApp() {
            trackingId = json.dictionaryObject![Constant.c_res_tracking_id] as! String?
            //            } else {
            //                trackingId = json.dictionaryObject![Constant.c_res_tracking_id] as! Int?
            //            }
        }
        if json[Constant.c_res_created_at].type != .null {
            createdAt = json.dictionaryObject![Constant.c_res_created_at] as! String?
        }
        if json[Constant.c_res_sale_by_id].type != .null {
            saleById = json.dictionaryObject![Constant.c_res_sale_by_id] as! Int?
        }
        if json[Constant.c_res_bill_to_address].type != .null {
            billToAddress = json.dictionaryObject![Constant.c_res_bill_to_address] as! String?
        }
        if json[Constant.c_res_carrier_id].type != .null {
            carrierId = json.dictionaryObject![Constant.c_res_carrier_id] as! Int?
        }
        if json[Constant.c_res_user_id].type != .null {
            userId = json.dictionaryObject![Constant.c_res_user_id] as! Int?
        }
        if json[Constant.c_res_ship_to_address].type != .null {
            shipToAddress = json.dictionaryObject![Constant.c_res_ship_to_address] as! String?
        }
        if json[Constant.c_res_product].type != .null {
            products = self.processProducts(json: json[Constant.c_res_product])
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        user = aDecoder.decodeObject(forKey: Constant.c_res_user) as? User
        confirmationDate = aDecoder.decodeObject(forKey: Constant.c_res_confirmation_date) as? String
        expectedDeliveryDate = aDecoder.decodeObject(forKey: Constant.c_res_expected_delivery_date) as? String
        invoiceNo = aDecoder.decodeObject(forKey: Constant.c_res_invoice_no) as? String
        shipByAddress = aDecoder.decodeObject(forKey: Constant.c_res_ship_by_address) as? String
        status = aDecoder.decodeObject(forKey: Constant.c_res_status) as? Int
        quatationId = aDecoder.decodeObject(forKey: Constant.c_res_id) as? Int
        //        if !Util.isSalesApp() {
        //            trackingId = aDecoder.decodeObject(forKey: Constant.c_res_tracking_id) as? Int
        //        }
        //        else {
        trackingId = aDecoder.decodeObject(forKey: Constant.c_res_tracking_id) as? String
        //        }
        createdAt = aDecoder.decodeObject(forKey: Constant.c_res_created_at) as? String
        
        saleById = aDecoder.decodeObject(forKey: Constant.c_res_created_at) as? Int
        billToAddress = aDecoder.decodeObject(forKey: Constant.c_res_bill_to_address) as? String
        carrierId = aDecoder.decodeObject(forKey: Constant.c_res_carrier_id) as? Int
        userId = aDecoder.decodeObject(forKey: Constant.c_res_user_id) as? Int
        shipToAddress = aDecoder.decodeObject(forKey: Constant.c_res_ship_to_address) as? String
        products = (aDecoder.decodeObject(forKey: Constant.c_res_product) as! [OrderProduct])
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(user, forKey: Constant.c_res_user)
        aCoder.encode(confirmationDate, forKey: Constant.c_res_confirmation_date)
        aCoder.encode(expectedDeliveryDate, forKey: Constant.c_res_expected_delivery_date)
        aCoder.encode(invoiceNo, forKey: Constant.c_res_invoice_no)
        aCoder.encode(shipByAddress, forKey: Constant.c_res_ship_by_address)
        aCoder.encode(status, forKey: Constant.c_res_status)
        aCoder.encode(quatationId, forKey: Constant.c_res_id)
        aCoder.encode(trackingId, forKey: Constant.c_res_tracking_id)
        aCoder.encode(createdAt, forKey: Constant.c_res_created_at)
        aCoder.encode(saleById, forKey: Constant.c_res_sale_by_id)
        aCoder.encode(billToAddress, forKey: Constant.c_res_bill_to_address)
        aCoder.encode(carrierId, forKey: Constant.c_res_carrier_id)
        aCoder.encode(userId, forKey: Constant.c_res_user_id)
        aCoder.encode(shipToAddress, forKey: Constant.c_res_ship_to_address)
        aCoder.encode(products, forKey: Constant.c_res_product)
    }
    
    func processProducts(json: JSON) -> [OrderProduct] {
        
        for i in 0 ..< json.count {
            let jsonValue = json.arrayValue[i]
            let product = OrderProduct(json: jsonValue)
            products.append(product)
        }
        return products
    }
    
    func processUser(json: JSON) -> User {
        return User(json: json)
    }
}
