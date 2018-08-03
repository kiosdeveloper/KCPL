//
//  ThemeShadowView.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 11/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import Foundation
@IBDesignable

class ThemeShadowView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var shadowColor: UIColor? = UIColor.darkGray
    @IBInspectable var shadowOpacity: Float = 0.2
    @IBInspectable var shadowRadius: CGFloat = 1.0
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowPath = shadowPath.cgPath
    }
    
    
    
}
