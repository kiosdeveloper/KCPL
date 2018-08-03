//
//  ItemDetailTableViewCell.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 04/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class ItemDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var manufactureNumberLabel: UILabel!
    
    @IBOutlet weak var portNumberLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    @IBOutlet weak var availableQuantityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        imagesCollectionView.delegate = dataSourceDelegate
        imagesCollectionView.dataSource = dataSourceDelegate
        imagesCollectionView.tag = row
        imagesCollectionView.setContentOffset(imagesCollectionView.contentOffset, animated:false)
        imagesCollectionView.reloadData()
    }

}
