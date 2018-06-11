//
//  DeliveryAddressCell.swift
//  KCPL
//
//  Created by Piyush Sanepara on 11/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class DeliveryAddressCell: UITableViewCell {

    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let button = self.editButton {
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.cornerRadius = 2.0
            button.clipsToBounds = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
