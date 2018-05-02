//
//  navController.swift
//  KCPL
//
//  Created by Aayushi Panchal on 02/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class navController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = ConstantsUI.C_Color_Theme
        self.navigationBar.titleTextAttributes = [kCTForegroundColorAttributeName: ConstantsUI.C_Color_White]
            as [NSAttributedStringKey : Any]
        self.navigationBar.tintColor = ConstantsUI.C_Color_White
        self.navigationBar.isTranslucent = false
        
    }
}
