//
//  VendorCustomerCell.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 09/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class VendorCustomerCell: UITableViewCell {

    @IBOutlet weak var contactNumberLabel: UILabel!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var gradeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataSource(customer: Customers) {
        self.contactNumberLabel.text = customer.phone ?? ""
        if customer.firstName == nil, customer.lastName == nil {
            self.companyNameLabel.text = customer.name ?? ""
        } else {
            self.companyNameLabel.text = "\(customer.firstName ?? "")  \(customer.lastName ?? "")"
        }
//        self.gradeLabel.text = ""
    }
    
    func setDataSource(vendor: Vendor) {
        self.contactNumberLabel.text = vendor.phone_no ?? ""
        if vendor.firstName == nil, vendor.lastName == nil {
            self.companyNameLabel.text = vendor.name ?? ""
        } else {
            self.companyNameLabel.text = "\(vendor.firstName ?? "")  \(vendor.lastName ?? "")"
        }
        //        self.gradeLabel.text = ""
    }
    
}
