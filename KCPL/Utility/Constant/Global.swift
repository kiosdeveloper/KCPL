//
//  Global.swift
//  KCPL
//
//  Created by Piyush Sanepara on 29/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//


var C_ServerName = "http://dev-kcpl.herokuapp.com"
let REGEX_EMAIL = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"

let C_UserDefault = UserDefaults.standard

let SalesScreen = "SalesScreen"
let PurchaseScreen = "PurchaseScreen"
let AdminVendorScreen = "AdminVendorScreen"
let AdminCustomerScreen = "AdminCustomerScreen"
let AdminDashboardScreen = "AdminDashboardScreen"
let AdminSelectCustomerScreen = "AdminSelectCustomerScreen"
let AdminSelectVendorScreen = "AdminSelectVendorScreen"
let AdminPendingQuatationScreen = "AdminPendingQuatationScreen"
let AdminHistoryQuatationScreen = "AdminHistoryQuatationScreen"


enum ScreenType {
    case SalesScreen
    case PurchaseScreen
    case AdminVendorScreen
    case AdminCustomerScreen
    case AdminDashboardScreen
    case AdminSelectCustomerScreen
    case AdminSelectVendorScreen
    case AdminPendingQuatationScreen
    case AdminHistoryQuatationScreen
}
