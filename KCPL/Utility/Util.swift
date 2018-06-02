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
    
}
