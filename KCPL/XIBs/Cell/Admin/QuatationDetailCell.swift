//
//  QuatationDetailCell.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 12/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class QuatationDetailCell: UITableViewCell {

    @IBOutlet weak var quatationDetailView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let view = self.quatationDetailView {
            view.layer.borderColor = ConstantsUI.C_Color_Theme.cgColor
            view.layer.borderWidth = 1.0
            view.clipsToBounds = true
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
