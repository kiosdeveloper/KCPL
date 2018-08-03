//
//  Util.swift
//  KCPL
//
//  Created by Piyush Sanepara on 16/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit
import MRProgress

class Util {
    
    static func isSalesApp() -> Bool {
        
        #if SALES
            return true
        #else
            return false
        #endif
    }
    
    static func isAdminApp() -> Bool {
        
        #if ADMIN
        return true
        #else
        return false
        #endif
    }
    
    static func isProgressing() -> Any? {
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            return MRProgressOverlayView.overlay(for: window)
        }
        return nil
    }
    
    static func showProgress() {
        
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            if isProgressing() == nil {
                MRProgressOverlayView.showOverlayAdded(to: window, animated: true)
            }
        }
    }
    
    static func dissmissProgress() {
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            MRProgressOverlayView.dismissOverlay(for: window, animated: true)
        }
    }
    
    func plusQuantity(product: Product, quantity: Int?) -> Product {
        
        if var cartArray_temp = UserDefault.getCartProducts(), cartArray_temp.count > 0 {
            if let product_temp = cartArray_temp.first(where: { $0.id == product.id }) {// if existing product available in cart
                
                if let qty = quantity {
                    product_temp.quantity = qty
                } else if let qty = product_temp.quantity {
                    product_temp.quantity = qty + 1
                }
                
                UserDefault.saveCartProducts(products: cartArray_temp)
                
                return product_temp
            } else {// if existing product not available in cart
                let product_temp = Product(product: product, quantity: quantity ?? 1)
                cartArray_temp.append(product_temp)
                UserDefault.saveCartProducts(products: cartArray_temp)
                return product_temp
            }
        } else { // if cart is empty
            var products = [Product]()
            let product_temp = Product(product: product, quantity: 1)
            products.append(product_temp)
            UserDefault.saveCartProducts(products: products)
            return product_temp
        }
    }
    
    func minusQuantity(product: Product) -> Product? {
        if let qty = product.quantity, qty > 0, let cartArray_temp = UserDefault.getCartProducts(), cartArray_temp.count > 0 {
            if let product_temp = cartArray_temp.first(where: { $0.id == product.id }) {// if existing product available in cart
                
                product_temp.quantity = qty - 1
                
                UserDefault.saveCartProducts(products: cartArray_temp)
                return product_temp
                
            } else {
                return nil
            }
        }
        return nil
    }
    
    func configBarButtonColor(color: UIColor) {
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: color], for: .normal)
    }
}
