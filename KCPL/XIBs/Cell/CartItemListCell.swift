//
//  CartItemListCell.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 11/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class CartItemListCell: UITableViewCell {

    @IBOutlet weak var itemContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let view = self.itemContentView {
            view.layer.borderColor = UIColor.black.cgColor
            view.layer.borderWidth = 1.0
            view.layer.cornerRadius = 2.0
            view.clipsToBounds = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
