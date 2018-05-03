//
//  ThemeLabel.swift
//  Botree911_Client
//
//  Created by piyushMac on 10/02/17.
//  Copyright © 2017 piyushMac. All rights reserved.
//

import UIKit

class ThemeLabelTitle: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.textColor = ConstantsUI.C_Color_darkGray
        self.font = UIFont.systemFont(ofSize: 16)
    }
}

class ThemeLabelLineLight: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = ConstantsUI.C_Color_darkGray
    }
}

class ThemeLabelLineDark: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = ConstantsUI.C_Color_Theme
    }
}

/*patel
class ThemeLabelTitle: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.textColor = themeTextColor
        self.font = UIFont.systemFont(ofSize: 14.0)
    }
}

class ThemeLabelDetail: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.textColor = UIColor.white
        self.font = UIFont.systemFont(ofSize: 12.0)
    }
}

class ThemeLabelTitleDarkBold: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.textColor = themeTextColorDark
        self.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
    }
}

class ThemeLabelTitleDark: UILabel {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.textColor = themeTextColorDark
    self.font = UIFont.systemFont(ofSize: 14.0)
  }
}

class ThemeLabelDetailDark: UILabel {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.textColor = themeTextColorDark
    self.font = UIFont.systemFont(ofSize: 12.0)
  }
}
class ThemeLabelDetailDarkBold: UILabel {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.textColor = themeTextColorDark
    self.font = UIFont.boldSystemFont(ofSize: 12.0)
  }
}

class ThemeLabelLine: UILabel {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.backgroundColor = themeLabelLineColor
  }
}
*/
