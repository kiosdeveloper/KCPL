//
//  UserDefault.swift
//  KCPL
//
//  Created by Piyush Sanepara on 29/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import Foundation

class UserDefault {
    
    //    MARK:- User Data
    private static func archiveUser(user : User) -> NSData {
        
        return NSKeyedArchiver.archivedData(withRootObject: user) as NSData
    }
    
    static func getUser() -> User? {
        
        if let unarchivedObject = C_UserDefault.object(forKey: Constant.c_ud_userData) as? Data {
            
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? User
        }
        
        return nil
    }
    
    static func saveUser(user : User?) {
        
        let archivedObject = archiveUser(user: user!)
        C_UserDefault.set(archivedObject, forKey: Constant.c_ud_userData)
        C_UserDefault.synchronize()
    }
    
    static func removeUser() {
        C_UserDefault.removeObject(forKey: Constant.c_ud_userData)
    }
    
    //    MARK:- Cart Data
    private static func archiveCartProducts(products : [Product]) -> NSData {
        
        return NSKeyedArchiver.archivedData(withRootObject: products) as NSData
    }
    
    static func getCartProducts() -> [Product]? {
        
        if let unarchivedObject = C_UserDefault.object(forKey: Constant.c_ud_cartData) as? Data {
            
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [Product]
        }
        
        return nil
    }
    
    static func saveCartProducts(products : [Product]?) {
        
        let archivedObject = archiveCartProducts(products: products!)
        C_UserDefault.set(archivedObject, forKey: Constant.c_ud_cartData)
        C_UserDefault.synchronize()
    }
    
    static func removeCartProducts() {
        C_UserDefault.removeObject(forKey: Constant.c_ud_cartData)
    }
}//End UserDefault
