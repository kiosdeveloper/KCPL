//
//  Constant.swift
//  KCPL
//
//  Created by Piyush Sanepara on 16/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

struct Constant {
    //    MARK:- For UI
    
    static let C_SideMenu_Home = "Home"
    static let C_SideMenu_MyCustomers = "My Customers"
    static let C_SideMenu_OrderHistory = "Order History"
    static let C_SideMenu_Address = "Address"
    static let C_SideMenu_About = "About"
    static let C_SideMenu_ContactUs = "Contact Us"
    static let C_SideMenu_VisitOurWebsite = "Visit Our Website"
    static let C_SideMenu_Profile = "Profile"
    static let C_SideMenu_SignOut = "Sign Out"

    //    MARK:- Error Messages
    static let c_error_email = "Please Enter Email-ID"
    static let c_error_valid_email = "Please Enter Valid Email-ID"
    static let c_error_password = "Please Enter Password"
    static let c_error_firstname = "Please Enter First Name"
    static let c_error_lastname = "Please Enter Last Name"
    static let c_error_companyname = "Please Enter Company Name"
    static let c_error_company_address = "Please Enter Company Address"
    static let c_error_mobile = "Please Enter Mobile Number"
    static let c_error_confirm_password = "Please Enter Confirm Password"
    static let c_not_match_confirm_password = "Your password and confirmation password do not match"
    static let c_error_gst_number = "Please Enter GST Number"
    static let c_error_delivery_address = "Please Enter Delivery Address"

//    MARK: For Request
    static let c_req_customer_email = "customer[email]"
    static let c_req_customer_password = "customer[password]"
    static let c_req_first_name = "customer[first_name]"
    static let c_req_last_name = "customer[last_name]"
    static let c_req_confirm_password = "customer[confirm_password]"
    static let c_req_device_token = "customer[device_token]"
    static let c_req_device_type = "customer[device_type]"
    static let c_req_address = "customer[address]"
    static let c_req_phone = "customer[phone]"
    
    static let c_req_ship_by_address = "order[ship_by_address]"
    static let c_req_bill_to_address = "order[bill_to_address]"
    static let c_req_ship_to_address = "order[ship_to_address]"
    static let c_req_sorder_products_attributes = "order[order_products_attributes]"
    
    static let c_req_adddress_line1 = "user_address[line_1]"
    static let c_req_adddress_line2 = "user_address[line_2]"
    static let c_req_adddress_city = "user_address[city]"
    static let c_req_adddress_state = "user_address[state]"
    static let c_req_adddress_country = "user_address[country]"
    static let c_req_adddress_zipcode = "user_address[zip]"
    
//    MARK: For Response
    static let c_res_type = "type"
    static let c_res_message = "message"
    static let c_res_status = "status"
    static let c_res_data = "data"
    
    static let c_res_id = "id"
    static let c_res_email = "email"
    static let c_res_first_name = "first_name"
    static let c_res_last_name = "last_name"
    static let c_res_phone = "phone"
    static let c_res_auth_token = "auth_token"
    static let c_res_address = "address"
    
    static let c_res_name = "name"
    static let c_res_image = "image"
    static let c_res_image_url = "image_url"
    
    static let c_res_description = "description"
    static let c_res_brand_name = "brand_name"
    static let c_res_tax = "tax"
    static let c_res_price = "price"
    static let c_res_quantity = "quantity"
    
    static let c_res_line1 = "line_1"
    static let c_res_line2 = "line_2"
    static let c_res_city = "city"
    static let c_res_state = "state"
    static let c_res_country = "country"
    static let c_res_zipcode = "zip"
    static let c_res_user_id = "user_id"
    
    static let c_res_confirmation_date = "confirmation_date"
    static let c_res_expected_delivery_date = "expected_delivery_date"
    static let c_res_invoice_no = "invoice_no"
    static let c_res_ship_by_address = "ship_by_address"
    static let c_res_ship_date = "ship_date"
    
    static let c_res_tracking_id = "tracking_id"
    static let c_res_created_at = "created_at"
    static let c_res_sale_by_id = "sale_by_id"
    static let c_res_bill_to_address = "bill_to_address"
    static let c_res_carrier_id = "carrier_id"
    static let c_res_ship_to_address = "ship_to_address"
    static let c_res_order_id = "order_id"
    static let c_res_qty = "qty"
    static let c_res_product_id = "product_id"
    static let c_res_product = "products"

    

    //    MARK:- Userdefault Keys
    static let c_ud_userData = "userData"
    static let c_ud_cartData = "cartData"
}
