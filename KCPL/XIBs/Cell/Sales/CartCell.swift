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
