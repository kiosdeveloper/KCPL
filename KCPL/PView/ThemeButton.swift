//
//  ThemeButton.swift
//  Botree911
//
//  Created by piyushMac on 01/02/17.
//  Copyright © 2017 piyushMac. All rights reserved.
//

import UIKit

class ThemeButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = ConstantsUI.C_Color_Theme
        self.setTitleColor(ConstantsUI.C_Color_White, for: UIControlState())
        self.titleLabel?.font = ConstantsUI.C_Font_LableTitle
    }
}

class ThemeButtonPlain: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setTitleColor(ConstantsUI.C_Color_Theme, for: UIControlState())
        self.titleLabel?.font = ConstantsUI.C_Font_LableTitle
    }
}

/*
class ThemeButtonSignUp: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setBackgroundImage(UIImage(named: "icon_bgsignup"), for: .normal)
        self.setTitleColor(UIColor.white, for: UIControlState())
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
}

class ThemeIntroButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setTitleColor(UIColor.white, for: UIControlState())
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
}
*/
