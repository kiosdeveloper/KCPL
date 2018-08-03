//
//  CartCell.swift
//  KCPL
//
//  Created by Piyush Sanepara on 08/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

protocol CartQuantityDelegate {
    func btnPlusQuantity(cell: CartCell)
    func btnMinusQuantity(cell: CartCell)
    func btnRemoveFromCart(cell: CartCell)
}

class CartCell: UITableViewCell {
    
    @IBOutlet weak var itemContentView: UIView!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productNameLabel: ThemeLabelTitle!
    
    @IBOutlet weak var productPriceLabel: ThemeLabelPrice!
    
    @IBOutlet weak var productQuantityTextfeild: UITextField!
    
    @IBOutlet weak var availableQuantityLabel: UILabel!
    
    
    var delegate: CartQuantityDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let view = self.itemContentView {
            //            view.layer.borderColor = UIColor.black.cgColor
            //            view.layer.borderWidth = 1.0
            //            view.layer.cornerRadius = 2.0
            //            view.clipsToBounds = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataSource(product: Product) {
        
        self.productNameLabel.text = product.name
        
        if let price = product.price {
            self.productPriceLabel.text = Double(price).convertCurrencyFormatter()
        }
        
        if let qty = product.quantity, let avaiQty = product.available_quantity {
            if avaiQty > 0 {
                self.productQuantityTextfeild.text = "\(qty)"
            } else {
                self.productQuantityTextfeild.text = nil
            }
            
        }
        
        self.availableQuantityLabel.text = "Qty " + "\(product.available_quantity ?? 0)"
    }
    
    //    MARK:- Actions
    @IBAction func btnPlusQuantityPressed(_ sender: Any) {
        if let _ = delegate {
            delegate?.btnPlusQuantity(cell: self)
        }
    }
    
    @IBAction func btnMinusQuantityPressed(_ sender: Any) {
        if let _ = delegate {
            delegate?.btnMinusQuantity(cell: self)
        }
    }
    
    @IBAction func btnRemoveFromCartPressed(_ sender: Any) {
        if let _ = delegate {
            delegate?.btnRemoveFromCart(cell: self)
        }
    }
}
