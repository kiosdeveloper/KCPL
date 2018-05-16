//
//  Util.swift
//  KCPL
//
//  Created by Piyush Sanepara on 16/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class Util {
    
    static func isSalesApp() -> Bool {
        
        #if SALES
            return true
        #else
            return false
        #endif
    }
}
