//
//  OrderHistoryDetailHeaderCell.swift
//  KCPL
//
//  Created by Piyush Sanepara on 29/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class OrderHistoryDetailHeaderCell: UITableViewCell {

    @IBOutlet weak var orderIdLabel: UILabel!
    
    @IBOutlet weak var submittedDateLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var orderStatusLabel: UILabel!
    
    @IBOutlet weak var shippingAddressLabel: UILabel!
    
    @IBOutlet weak var billingAddressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
