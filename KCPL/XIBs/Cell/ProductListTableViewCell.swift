//
//  ProductListTableViewCell.swift
//  KCPL
//
//  Created by Piyush Sanepara on 29/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

protocol ProductListDelegate {
    func btnPlusQuantity(cell: ProductListTableViewCell)
    func btnMinusQuantity(cell: ProductListTableViewCell)
    func btnAddToCart(cell: ProductListTableViewCell)
}

class ProductListTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var minusButton: ThemeButton!
    
    @IBOutlet weak var plusButton: ThemeButton!
    
    @IBOutlet weak var quantityTextField: UITextField!
    
    @IBOutlet weak var addToCartButton: ThemeButton!
    
    var delegate: ProductListDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
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
    
    @IBAction func btnAddToCartPressed(_ sender: Any) {
        if let _ = delegate {
            delegate?.btnAddToCart(cell: self)
        }
    }

}
