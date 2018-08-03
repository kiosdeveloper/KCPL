//
//  InventoryTableViewCell.swift
//  KCPL
//
//  Created by Piyush Sanepara on 07/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

protocol InventoryTableViewDelegate {
    func isSelectButton(cell: InventoryTableViewCell)
}

class InventoryTableViewCell: UITableViewCell {

    @IBOutlet var selectButton: UIButton!
    
    @IBOutlet var productNameLabel: ThemeLabelDetail!
    
    @IBOutlet var inStockLabel: ThemeLabelDetail!
    
    @IBOutlet var committedLabel: ThemeLabelDetail!
    
    @IBOutlet var availabelLabel: ThemeLabelDetail!
    
    @IBOutlet var productNameLeadingConstraint: NSLayoutConstraint!
    
    var delegate: InventoryTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataSource(product: Product) {
        self.productNameLabel.text = product.name
        
        if let inStock = product.awaiting_quantity {
            self.inStockLabel.text = "\(inStock)"
            if inStock > 100 {
                self.inStockLabel.backgroundColor = UIColor.clear
                self.inStockLabel.textColor = ConstantsUI.C_Color_darkGray
            } else {
                self.inStockLabel.backgroundColor = UIColor.red
                self.inStockLabel.textColor = UIColor.white
            }
        } else {
            self.inStockLabel.text = "0"
            self.inStockLabel.backgroundColor = UIColor.red
            self.inStockLabel.textColor = UIColor.white
        }
        
        self.committedLabel.text = "\(product.commited_quantity ?? 0)"
        self.availabelLabel.text = "\(product.available_quantity ?? 0)"
        
        selectButton.isSelected = product.isSelect ?? false
    }
    
    func configCellUI(fromScreenType: ScreenType?) {
        self.selectButton.isHidden = (fromScreenType == nil)
        self.productNameLeadingConstraint.constant = ((fromScreenType == nil) ? -24 : 4)
    }
    
    func configCellUISales() {
        self.selectButton.isHidden = Util.isSalesApp()
        self.productNameLeadingConstraint.constant = (Util.isSalesApp() ? -24 : 4)
    }
    
    //    MARK:- Actions
    @IBAction func isSelectButtonPressed(_ sender: Any) {
        if let _ = delegate {
            delegate?.isSelectButton(cell: self)
        }
    }
}
