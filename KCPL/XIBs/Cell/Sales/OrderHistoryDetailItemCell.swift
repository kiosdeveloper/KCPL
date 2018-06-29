//
//  OrderHistoryDetailItemCell.swift
//  KCPL
//
//  Created by Piyush Sanepara on 29/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class OrderHistoryDetailItemCell: UITableViewCell {

    @IBOutlet var productImageView: UIImageView!
    
    @IBOutlet var productNameLabel: ThemeLabelTitle!
    
    @IBOutlet var productPriceLabel: ThemeLabelPrice!
    
    @IBOutlet var productQtyLabel: ThemeLabelTitle!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
