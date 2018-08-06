//
//  QuatationDetailCell.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 12/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit
import SDWebImage

class QuatationDetailCell: UITableViewCell {

    @IBOutlet weak var quatationDetailView: UIView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var stockLabel: UILabel!
    
    @IBOutlet weak var committedLabel: UILabel!
    
    @IBOutlet weak var availableLabel: UILabel!
    
    @IBOutlet weak var requestedLabel: UILabel!
    
    @IBOutlet var quantityLabel: ThemeLabelTitle!
    override func awakeFromNib() {
        super.awakeFromNib()
        if let view = self.quatationDetailView {
            view.layer.borderColor = ConstantsUI.C_Color_Theme.cgColor
            view.layer.borderWidth = 1.0
            view.clipsToBounds = true
        }
        if let imageView = self.productImageView {
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataSource(product: OrderProduct) {
        self.productImageView.sd_setImage(with: URL(string: product.image_url ?? ""), placeholderImage: #imageLiteral(resourceName: "item_detail"), completed: nil)
        self.productNameLabel.text = product.name ?? ""
        self.productDescriptionLabel.text = ""
        self.totalLabel.text = ((product.price ?? 0.0) + (product.tax ?? 0.0)).convertCurrencyFormatter()
        self.quantityLabel.text = "Qty " + ("\(product.qty ?? 0)")
        
    }

}
