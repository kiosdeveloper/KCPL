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

extension UITextField {
    func addRightSubView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 12))
        let imgView = UIImageView(frame: CGRect(x: 0.0, y: 0, width: 12, height: 12))
        imgView.image = UIImage(named: "down-arrow")
        imgView.contentMode = .center
        view.addSubview(imgView)
        self.rightView = view
        rightViewMode = .always
    }
}
