//
//  ThemeTableView.swift
//  KCPL
//
//  Created by Piyush Sanepara on 15/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class ThemeTableView: UITableView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.separatorStyle = .none
        self.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
    }
}
