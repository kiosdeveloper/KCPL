//
//  HistoryQuatationCell.swift
//  KCPL
//
//  Created by Piyush Sanepara on 08/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

protocol HistoryQuatationDelegate {
    func reAcceptButton(cell: HistoryQuatationCell)
}

class HistoryQuatationCell: UITableViewCell {

    @IBOutlet weak var quatationIdLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet var reacceptButton: UIButton!
    
    @IBOutlet var rejectedLabel: ThemeLabelDetail!
    
    var delegate: HistoryQuatationDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataSource(quatation: Quatations) {
        self.quatationIdLabel.text = "Order #\(quatation.quatationId ?? 0)"
        self.timeLabel.text = quatation.createdAt!.convertOrderCreatedDate().getElapsedInterval()

        if let firstName = quatation.user?.first_name, let lastName = quatation.user?.last_name {
            self.userNameLabel.text = firstName + " " + lastName
        }
        else {
            self.userNameLabel.text = ""
        }
        
        self.addressLabel.text = quatation.billToAddress ?? ""
    }
    
    func configReaaceptButtonRejectLabel(status: Int) {
        if status < 0 {//show rejected and reaccept
            self.reacceptButton.isHidden = false
            self.rejectedLabel.text = "REJECTED"
        } else {//show accepted label
            self.reacceptButton.isHidden = true
            self.rejectedLabel.text = "ACCEPTED"
        }
    }
    
    @IBAction func reAcceptClicked(_ sender: UIButton) {
        if let _ = delegate {
            delegate?.reAcceptButton(cell: self)
        }
    }
}
