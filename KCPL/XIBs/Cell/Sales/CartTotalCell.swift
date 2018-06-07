//
//  CartTotalCell.swift
//  KCPL
//
//  Created by Aayushi Panchal on 10/05/18.
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

}
