//
//  ThemeSearchBar.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 05/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class ThemeSearchBar: UISearchBar {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.barTintColor = ConstantsUI.C_Color_Theme
    }
}
