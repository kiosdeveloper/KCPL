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
    static let C_SideMenu_About = "About"
    static let C_SideMenu_ContactUs = "Contact Us"
    static let C_SideMenu_VisitOurWebsite = "Visit Our Website"
    static let C_SideMenu_SignOut = "Sign Out"
    
    //    MARK:- Error Messages
    static let c_error_email = "Please Enter Email-ID"
    static let c_error_valid_email = "Please Enter Valid Email-ID"
    static let c_error_password = "Please Enter Password"
    
//    MARK: For Request
    static let c_req_customer_email = "customer[email]"
    static let c_req_customer_password = "customer[password]"
    
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
    
    //    MARK:- Userdefault Keys
    static let c_ud_userData = "userData"
}
