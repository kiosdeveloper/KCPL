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
    
    func convertOrderCreatedDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let dateString = dateFormatter.string(from: date!)
        return dateFormatter.date(from: dateString)!
    }
}

extension Double {
    func convertCurrencyFormatter() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        
        return currencyFormatter.string(for: self)!
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
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // as @nhgrif suggested, we can skip the string manipulations if
        // the beginning of the textView.text is not touched.
        guard range.location == 0 else {
            return true
        }
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: text!) as NSString
        return newString.rangeOfCharacter(from: NSCharacterSet.whitespacesAndNewlines).location != 0
    }
}

extension UIButton {
    
    func isEnableConfig() {
        self.isEnabled = true
        self.alpha = 1
    }
    
    func isDisableConfig() {
        self.isEnabled = false
        self.alpha = 0.5
    }
    
}

extension CAShapeLayer {
    func drawCircleAtLocation(location: CGPoint, withRadius radius: CGFloat, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        let origin = CGPoint(x: location.x - radius, y: location.y - radius)
        path = UIBezierPath(ovalIn: CGRect(origin: origin, size: CGSize(width: radius * 2, height: radius * 2))).cgPath
    }
}

private var handle: UInt8 = 0;

extension UIBarButtonItem {
    
    private var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }
    
    func addBadge(number: Int, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.orange, andFilled filled: Bool = true) {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        
        badgeLayer?.removeFromSuperlayer()
        
        // Initialize Badge
        let badge = CAShapeLayer()
        let radius = CGFloat(7)
        let location = CGPoint(x: view.frame.width - (radius + offset.x), y: (radius + offset.y))
        badge.drawCircleAtLocation(location: location, withRadius: radius, andColor: color, filled: filled)
        view.layer.addSublayer(badge)
        
        // Initialiaze Badge's label
        let label = CATextLayer()
        label.string = "\(number)"
        label.alignmentMode = kCAAlignmentCenter
        label.fontSize = 11
        label.frame = CGRect(origin: CGPoint(x: location.x - 4, y: offset.y), size: CGSize(width: 8, height: 16))
        label.foregroundColor = filled ? ConstantsUI.C_Color_White.cgColor : color.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)
        
        // Save Badge as UIBarButtonItem property
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func updateBadge(number: Int) {
        if let text = badgeLayer?.sublayers?.filter({ $0 is CATextLayer }).first as? CATextLayer {
            text.string = "\(number)"
        }
    }
    
    func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
    
}

extension Date {
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func getElapsedInterval() -> String {
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "hour ago" :
                "\(hour)" + " " + "hours ago"
        }
        else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "minute ago" :
                "\(minute)" + " " + "minutes ago"
        }
        return "A moment ago"
    }
}
