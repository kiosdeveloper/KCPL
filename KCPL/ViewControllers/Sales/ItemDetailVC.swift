//
//  ItemDetailVC.swift
//  KCPL
//
//  Created by Aayushi Panchal on 04/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class ItemDetailVC: AbstractVC {
    
    @IBOutlet weak var itemDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemDetailTableView.rowHeight = UITableViewAutomaticDimension
        self.itemDetailTableView.estimatedRowHeight = 500
    }
    
    @IBAction func addToCartClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func previousClicked(_ sender: UIButton) {
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
    }
}

extension ItemDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemDetailCell") as! ItemDetailTableViewCell
            cell.itemNameLabel.text = "Carburetor-Innova Crysta-\n2.8 Z,Direct Fit"
            cell.manufactureNumberLabel.text = "Manufacture Number: 11250"
            cell.portNumberLabel.text = "Part No: A123587"
            cell.priceLabel.text = "Rs. 2975 + GST extra applicable"
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! ItemDetailTableViewCell
            cell.itemDescriptionLabel.text = "Radiaters are heat exchangers used for cooling internal combustion engines, mainly in automobiles but also in piston-engined aircraft, railway locomatives, motercycles,stationary etc."
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            guard let tableViewCell = cell as? ItemDetailTableViewCell else { return }
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension ItemDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageListCell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width * 0.6)
    }
    
}
