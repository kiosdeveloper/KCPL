//
//  OrderHistoryTableViewCell.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 11/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class OrderHistoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var orderIdLabel: UILabel!
    
    @IBOutlet weak var processingLabel: UILabel!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var submittedDateLabel: UILabel!
    
    @IBOutlet weak var shippingToLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let button = self.confirmButton {
            button.layer.cornerRadius = button.frame.size.height / 2.0
            button.clipsToBounds = true
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
