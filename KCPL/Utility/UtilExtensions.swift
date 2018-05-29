//
//  UtilExtensions.swift
//  KCPL
//
//  Created by Aayushi Panchal on 03/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit
import BRYXBanner

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedStringKey: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func configToast(isError: Bool) {
//        let imgBanner = UIImage(named: isError ? "error" : "success")
        
        let banner = Banner(title: self, subtitle: nil, image: nil, backgroundColor: ConstantsUI.C_Color_Theme)
        
        banner.dismissesOnTap = true
        banner.show(duration: 2.0)
    }
    
    func isValidEmail() -> Bool {
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", REGEX_EMAIL)
        return emailTest.evaluate(with: self)
    }
}

extension UISearchBar {
    
}
