//
//  CartVC.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 05/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class CartVC: AbstractVC {

    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    var cartProductsDatasource = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cartTableView.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        
        if let cartArray_temp = UserDefault.getCartProducts() {
            cartProductsDatasource = cartArray_temp
        }
        
    }
    @IBAction func btnNextPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "showDeliveryAddressFromCart", sender: nil)
    }
    
}

extension CartVC: UITableViewDelegate, UITableViewDataSource, CartQuantityDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return cartProductsDatasource.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartItemListCell") as! CartItemListCell
            cell.delegate = self
            
            cell.productNameLabel.text = cartProductsDatasource[indexPath.row].name
            
            if let price = cartProductsDatasource[indexPath.row].price {
                cell.productPriceLabel.text = "\(price) Rs."
            }
            
            cell.productQuantityTextfeild.text = "\(cartProductsDatasource[indexPath.row].quantity)"
            
            
            return cell
        } else {
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartTotalCell") as! CartTotalCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return titleLabel
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        } else {
            return 0
        }
    }
    
    func btnPlusQuantity(cell: CartItemListCell) {
        guard let indexPath = self.cartTableView.indexPath(for: cell) else { return }
        
        print("+ \(indexPath.row) pressed")
        
        cartProductsDatasource[indexPath.row].quantity += 1
        UserDefault.saveCartProducts(products: cartProductsDatasource)
        cartTableView.reloadRows(at: [indexPath], with: .none)
        
        
    }
    
    func btnMinusQuantity(cell: CartItemListCell) {
        guard let indexPath = self.cartTableView.indexPath(for: cell) else { return }
        
        print("- \(indexPath.row) pressed")
        
        if self.cartProductsDatasource[indexPath.row].quantity > 0 {
            cartProductsDatasource[indexPath.row].quantity -= 1
            UserDefault.saveCartProducts(products: cartProductsDatasource)
            cartTableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func btnRemoveFromCart(cell: CartItemListCell) {
        guard let indexPath = self.cartTableView.indexPath(for: cell) else { return }
        
        print("remove \(indexPath.row) pressed")
        
        if self.cartProductsDatasource[indexPath.row].quantity > 0 {
            cartProductsDatasource.remove(at: indexPath.row)
            
            UserDefault.saveCartProducts(products: cartProductsDatasource)
            cartTableView.deleteRows(at: [indexPath], with: .middle)
        }
    }
}

//MARK:- SideMenu
extension CartVC: SlideNavigationControllerDelegate {
    
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool
    {
        return true
    }
}
