//
//  CartTotalCell.swift
//  KCPL
//
//  Created by Piyush Sanepara on 08/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class CartTotalCell: UITableViewCell {
    
    @IBOutlet var subTotalLable: ThemeLabelDetail!
    
    @IBOutlet var shippingLable: ThemeLabelDetail!
    
    @IBOutlet var gstLabel: ThemeLabelDetail!
    
    @IBOutlet var totalLabel: ThemeLabelTitle!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataSource(products: [Product]) {
        
//        var subtotle = 0
//        var tax = 0.0
//
//        for cartProduct in products {
//            if let qty = cartProduct.quantity {
//                if let productPrice = cartProduct.price {
//                    subtotle += (productPrice * qty)
//                }
//
//                if let productGST = cartProduct.tax {
//                    tax += (productGST * Double(qty))
//                }
//            }
//        }
        
        self.shippingLable.text = 0.0.convertCurrencyFormatter()
        self.subTotalLable.text = self.countSubTotalTax(products: products).0.convertCurrencyFormatter()

//        self.subTotalLable.text = Double(subtotle).convertCurrencyFormatter()
//        self.gstLabel.text = tax.convertCurrencyFormatter()
        self.gstLabel.text = self.countSubTotalTax(products: products).1.convertCurrencyFormatter()
        self.totalLabel.text = (self.countSubTotalTax(products: products).0 + self.countSubTotalTax(products: products).1 ).convertCurrencyFormatter()
    }
    
    func countSubTotalTax(products: [Product]) -> (Double,Double) {
        var total = 0.0
        var tax = 0.0
        for product in products {
            total = (Double(product.price ?? 0) * Double(product.quantity ?? 0)) + total
            tax = ((product.tax ?? 0) * Double(product.quantity ?? 0)) + tax
        }
        return (total,tax)
    }
}
