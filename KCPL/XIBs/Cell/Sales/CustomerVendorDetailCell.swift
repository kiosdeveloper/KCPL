//
//  CustomerVendorDetailCell.swift
//  KCPL
//
//  Created by Piyush Sanepara on 11/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class CustomerVendorDetailCell: UITableViewCell {
    
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
    
    func setDataSource(customer: Customers?) {
        self.companyNameLabel.text = " "
        
        self.companyAddressLabel.text = customer?.address ?? ""
        
        self.contactLabel.text = customer?.phone ?? ""
        
        self.emailLabel.text = customer?.email ?? ""
        
        if customer?.firstName == nil, customer?.lastName == nil {
            self.personNameLabel.text = "Mr. \(customer?.name ?? "")"
        } else {
            self.personNameLabel.text = "Mr. \(customer?.firstName ?? "")  \(customer?.lastName ?? "")"
        }
    }
    
    func setDataSource(vendor: Vendor?) {
        self.companyNameLabel.text = " "
        
        var address = String()
        if let add1 = vendor?.address_line_1 {
            address.append(add1)
        }
        
        if let add2 = vendor?.address_line_2 {
            address.append("\n\(add2)")
        }
        
        self.companyAddressLabel.text = address.trimmingCharacters(in: .whitespacesAndNewlines)
        
        self.contactLabel.text = vendor?.phone_no ?? ""
        
        self.emailLabel.text = vendor?.email ?? ""
        
        if vendor?.firstName == nil, vendor?.lastName == nil {
            self.personNameLabel.text = "Mr. \(vendor?.name ?? "")"
        } else {
            self.personNameLabel.text = "Mr. \(vendor?.firstName ?? "")  \(vendor?.lastName ?? "")"
        }
    }
}
