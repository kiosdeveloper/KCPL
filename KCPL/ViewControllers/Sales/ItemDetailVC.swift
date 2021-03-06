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
    @IBOutlet weak var addToCartButton: ThemeButton!

    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemDetailTableView.rowHeight = UITableViewAutomaticDimension
        self.itemDetailTableView.estimatedRowHeight = 500
        
        if let cartArray_temp = UserDefault.getCartProducts(), let i = cartArray_temp.index(where: { $0.id == product.id }) {
            addToCartButton.isDisableConfig()
            addToCartButton.setTitle("Added", for: .normal)
        }
        
//        let textAttributes = [NSAttributedStringKey.foregroundColor:ConstantsUI.C_Color_Title]
//        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
//    MARK:- Action
    @IBAction func addToCartClicked(_ sender: Any) {
        
        if self.product.available_quantity ?? 0 > 0 {
            self.product = Util().plusQuantity(product: self.product, quantity: nil)
            self.navigationController?.popViewController(animated: true)
        } else {
            "Out Of Stock".configToast(isError: true)
        }
        
        /*
        if let qty = self.product.quantity {
            self.product.quantity = qty + 1
        }
        
        if var cartArray_temp = UserDefault.getCartProducts() {
            cartArray_temp.append(self.product)
            UserDefault.saveCartProducts(products: cartArray_temp)
        }*/
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
            cell.itemNameLabel.text = self.product.name //"Carburetor-Innova Crysta-\n2.8 Z,Direct Fit"
            cell.manufactureNumberLabel.text = "Manufacture Number: 11250"
            cell.portNumberLabel.text = "Part No: A123587"
            if let price = self.product.price, let tax = self.product.percentageTax {
                cell.priceLabel.text = "\(Double(price).convertCurrencyFormatter()) + \(tax)% GST extra applicable"
            }
            
            cell.availableQuantityLabel.text = "Qty " + "\(self.product.available_quantity ?? 0)"
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! ItemDetailTableViewCell
            cell.itemDescriptionLabel.text = self.product.descriptionProduct // "Radiaters are heat exchangers used for cooling internal combustion engines, mainly in automobiles but also in piston-engined aircraft, railway locomatives, motercycles,stationary etc."
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageListCell", for: indexPath) as! ImagesListCollectionViewCell
        cell.itemImageView.sd_setImage(with: URL.init(string: self.product.imageUrl!), placeholderImage: UIImage.init(named: "item_detail"), options: .fromCacheOnly, completed: nil)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width * 0.6)
    }
    
}
