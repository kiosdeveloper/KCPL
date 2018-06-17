//
//  DeliveryAddressCell.swift
//  KCPL
//
//  Created by Piyush Sanepara on 11/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

protocol AddressListDelegate {
    func editAddress(cell: DeliveryAddressCell)
    func selectAddress(cell: DeliveryAddressCell)
}

class DeliveryAddressCell: UITableViewCell {

    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNumberLabel: UILabel!
    @IBOutlet weak var selectButtonWidthConstraint: NSLayoutConstraint!
    
    var delegate: AddressListDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func editClicked(_ sender: UIButton) {
        if let _ = delegate {
            delegate?.editAddress(cell: self)
        }
    }
    
    @IBAction func selectAddressClicked(_ sender: UIButton) {
        if let _ = delegate {
            delegate?.selectAddress(cell: self)
        }
    }
}
