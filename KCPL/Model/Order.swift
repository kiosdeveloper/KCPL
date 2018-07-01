//
//  OrderHistory.swift
//  KCPL
//
//  Created by MacBook Pro on 29/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit
import SwiftyJSON

class Order: NSObject, NSCoding {
    
    var confirmationDate: String?
    var expectedDeliveryDate : String?
    var invoiceNo: String?
    var shipByAddress : String?
    var status: Int?
    var orderId: Int?
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
    
    init(order: Order) {
        self.confirmationDate = order.confirmationDate
        self.expectedDeliveryDate = order.expectedDeliveryDate
        self.invoiceNo = order.invoiceNo
        self.products = order.products
        self.shipByAddress = order.shipByAddress
        self.status = order.status
        self.orderId = order.orderId
        self.trackingId = order.trackingId
        self.createdAt = order.createdAt
        self.saleById = order.saleById
        self.billToAddress = order.billToAddress
        self.carrierId = order.carrierId
        self.userId = order.userId
        self.shipToAddress = order.shipToAddress

    }
    
    init(json: JSON) {
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
            orderId = json.dictionaryObject![Constant.c_res_id] as! Int?
        }
        if json[Constant.c_res_tracking_id].type != .null {
            if !Util.isSalesApp() {
                trackingId = json.dictionaryObject![Constant.c_res_tracking_id] as! Int?
            }
            else {
                trackingId = json.dictionaryObject![Constant.c_res_tracking_id] as! String?
            }
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
        super.init()
        if json[Constant.c_res_product].type != .null {
            products = self.processProducts(json: json[Constant.c_res_product])
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        confirmationDate = aDecoder.decodeObject(forKey: Constant.c_res_confirmation_date) as? String
        expectedDeliveryDate = aDecoder.decodeObject(forKey: Constant.c_res_expected_delivery_date) as? String
        invoiceNo = aDecoder.decodeObject(forKey: Constant.c_res_invoice_no) as? String
        shipByAddress = aDecoder.decodeObject(forKey: Constant.c_res_ship_by_address) as? String
        status = aDecoder.decodeObject(forKey: Constant.c_res_status) as? Int
        orderId = aDecoder.decodeObject(forKey: Constant.c_res_id) as? Int
        if !Util.isSalesApp() {
            trackingId = aDecoder.decodeObject(forKey: Constant.c_res_tracking_id) as? Int
        }
        else {
            trackingId = aDecoder.decodeObject(forKey: Constant.c_res_tracking_id) as? String
        }
        createdAt = aDecoder.decodeObject(forKey: Constant.c_res_created_at) as? String
        
        saleById = aDecoder.decodeObject(forKey: Constant.c_res_created_at) as? Int
        billToAddress = aDecoder.decodeObject(forKey: Constant.c_res_bill_to_address) as? String
        carrierId = aDecoder.decodeObject(forKey: Constant.c_res_carrier_id) as? Int
        userId = aDecoder.decodeObject(forKey: Constant.c_res_user_id) as? Int
        shipToAddress = aDecoder.decodeObject(forKey: Constant.c_res_ship_to_address) as? String
        products = (aDecoder.decodeObject(forKey: Constant.c_res_product) as! [OrderProduct])
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(confirmationDate, forKey: Constant.c_res_confirmation_date)
        aCoder.encode(expectedDeliveryDate, forKey: Constant.c_res_expected_delivery_date)
        aCoder.encode(invoiceNo, forKey: Constant.c_res_invoice_no)
        aCoder.encode(shipByAddress, forKey: Constant.c_res_ship_by_address)
        aCoder.encode(status, forKey: Constant.c_res_status)
        aCoder.encode(orderId, forKey: Constant.c_res_id)
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
}
