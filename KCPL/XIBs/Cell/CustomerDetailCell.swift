//
//  CustomerDetailCell.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 12/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class CustomerDetailCell: UITableViewCell {

    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var companyAddressLabel: UILabel!
    
    @IBOutlet weak var contactLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var personNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
