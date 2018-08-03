//
//  PendingQuatationCell.swift
//  KCPL
//
//  Created by Piyush Sanepara on 08/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

protocol PendingQuatationDelegate {
    func acceptButton(cell: PendingQuatationCell)
    func rejectButton(cell: PendingQuatationCell)
}

class PendingQuatationCell: UITableViewCell {

    @IBOutlet weak var orderIdLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    var delegate: PendingQuatationDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataSource(quatation: Quatations) {
        self.orderIdLabel.text = "Order #\(quatation.quatationId ?? 0)"
        self.timeLabel.text = quatation.createdAt!.convertOrderCreatedDate().getElapsedInterval()
        
        if let firstName = quatation.user?.first_name, let lastName = quatation.user?.last_name {
            self.userNameLabel.text = firstName + " " + lastName
        }
        else {
            self.userNameLabel.text = ""
        }
        
        self.addressLabel.text = quatation.billToAddress ?? ""
    }
    
    //    MARK:- Actions
    @IBAction func acceptButtonPressed(_ sender: Any) {
        if let _ = delegate {
            delegate?.acceptButton(cell: self)
        }
    }
    
    @IBAction func rejectButtonPressed(_ sender: Any) {
        if let _ = delegate {
            delegate?.rejectButton(cell: self)
        }
    }
    
}
