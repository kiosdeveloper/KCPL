//
//  AdminSalesTableViewCell.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 07/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminSalesTableViewCell: UITableViewCell {

    @IBOutlet weak var orderNumberLabel: UILabel!

    @IBOutlet weak var companyNameLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataSource(order: Order) {
        if let orderId = order.orderId {
            self.orderNumberLabel.text = "Sales Order- #" + "\(orderId)"
        } else {
            self.orderNumberLabel.text = "Sales Order- #"
        }
        if let firstName = order.user?.first_name, let lastName = order.user?.last_name {
            self.companyNameLabel.text = firstName + " " + lastName
        }
        else {
            self.companyNameLabel.text = ""
        }
        self.timeLabel.text = order.createdAt!.convertOrderCreatedDate().getElapsedInterval() // self.convertOrderCreateDate(createdDate: order.createdAt!).getElapsedInterval()
    }
    
}
