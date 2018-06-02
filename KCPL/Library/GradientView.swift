//
//  GradientView.swift
//  GuidedExplorers
//
//  Created by Apple on 18/09/17.
//  Copyright © 2017 KCPL. All rights reserved.
//

import UIKit

@objc @IBDesignable class GradientView: UIView {

    var gradientLayer: CAGradientLayer = CAGradientLayer()
    @IBInspectable var firstColor: UIColor = UIColor.red
    @IBInspectable var secondColor: UIColor = UIColor.green
    
    @IBInspectable var vertical: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyGradient(self.bounds)
    }
    
    func applyGradient(_ rect: CGRect) {
        let colors = [firstColor.cgColor, secondColor.cgColor]
        
        gradientLayer.colors = colors
        gradientLayer.frame = rect
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
        
        self.layer.addSublayer(gradientLayer)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradientLayer.frame = self.bounds
        #if TARGET_INTERFACE_BUILDER
            applyGradient()
        #endif
    }
}

@objc @IBDesignable class ThreeColorsGradientView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor.red
    @IBInspectable var secondColor: UIColor = UIColor.green
    @IBInspectable var thirdColor: UIColor = UIColor.blue
    var gradientLayer: CAGradientLayer = CAGradientLayer()

    @IBInspectable var vertical: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyGradient(self.bounds)
    }
    
    func applyGradient(_ rect: CGRect) {
        let colors = [firstColor.cgColor, secondColor.cgColor, thirdColor.cgColor]
        
        gradientLayer.colors = colors
        gradientLayer.frame = rect
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
        
        self.layer.addSublayer(gradientLayer)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradientLayer.frame = self.bounds
        #if TARGET_INTERFACE_BUILDER
            applyGradient()
        #endif
    }
}

@IBDesignable class RadialGradientView: UIView {
    
    @IBInspectable var outsideColor: UIColor = UIColor.red
    @IBInspectable var insideColor: UIColor = UIColor.green
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyGradient()
    }
    
    func applyGradient() {
        let colors = [insideColor.cgColor, outsideColor.cgColor] as CFArray
        let endRadius = sqrt(pow(frame.width/2, 2) + pow(frame.height/2, 2))
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        let context = UIGraphicsGetCurrentContext()
        
        context?.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        #if TARGET_INTERFACE_BUILDER
            applyGradient()
        #endif
    }

}
