//
//  SelectCustomerCell.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 09/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class SelectCustomerCell: UITableViewCell {
    
    @IBOutlet weak var contactNumberLabel: UILabel!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var gradeLabel: UILabel!
    
    @IBOutlet weak var selectCustomerImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
