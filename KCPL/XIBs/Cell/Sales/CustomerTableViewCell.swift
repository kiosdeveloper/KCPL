//
//  CustomerTableViewCell.swift
//  KCPL
//
//  Created by Piyush Sanepara on 15/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class CustomerTableViewCell: UITableViewCell {

    @IBOutlet weak var customerNameLabel: UILabel!
    
    @IBOutlet weak var customerAddressLabel: UILabel!
    
    @IBOutlet weak var customerNumberLabel: UILabel!

    @IBOutlet weak var customerEmailLabel: UILabel!

    @IBOutlet weak var selectCustomerButton: UIButton!

    @IBOutlet weak var selectButtonWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
