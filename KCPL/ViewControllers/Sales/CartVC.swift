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
    
    @IBOutlet weak var nextButton: ThemeButton!
    
    var cartProductsDatasource = [Product]()
    var productsDatasource = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cartTableView.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        
//        if let cartArray_temp = UserDefault.getCartProducts() {
//            cartProductsDatasource = cartArray
//        }
        cartProductsDatasource = cartArray
        self.configNavigationBar()
    }
    
    func configNavigationBar() {
        self.title = "Cart"
        let textAttributes = [NSAttributedStringKey.foregroundColor:ConstantsUI.C_Color_Title]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
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
        
        cartTableView.isHidden = !(cartProductsDatasource.count > 0)
        nextButton.isHidden = !(cartProductsDatasource.count > 0)

        if section == 0 {
            return cartProductsDatasource.count
        } else {
            return (cartProductsDatasource.count > 0) ? 1 : 0
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
        for cart in cartArray  where cart.id == cartProductsDatasource[indexPath.row].id {
            cart.quantity = cartProductsDatasource[indexPath.row].quantity
        }
        
//        UserDefault.saveCartProducts(products: cartProductsDatasource)
////        cartTableView.reloadRows(at: [indexPath], with: .none)
        cartTableView.reloadData()
    }
    
    func btnMinusQuantity(cell: CartItemListCell) {
        guard let indexPath = self.cartTableView.indexPath(for: cell) else { return }
        
        
        if self.cartProductsDatasource[indexPath.row].quantity > 0 {
            cartProductsDatasource[indexPath.row].quantity -= 1
            
            if self.cartProductsDatasource[indexPath.row].quantity == 0 {
                for (index, cart) in cartArray.enumerated() where cart.id == cartProductsDatasource[indexPath.row].id {
                    cartArray.remove(at: index)
                }
            } else {
                for cart in cartArray {
                    if cart.id == cartProductsDatasource[indexPath.row].id {
                        cart.quantity = cartProductsDatasource[indexPath.row].quantity
                    }
                }
            }
            cartTableView.reloadData()
            
//            UserDefault.saveCartProducts(products: cartProductsDatasource)
//            cartTableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func btnRemoveFromCart(cell: CartItemListCell) {
        guard let indexPath = self.cartTableView.indexPath(for: cell) else { return }
        
        print("remove \(indexPath.row) pressed")
        
        if self.cartProductsDatasource[indexPath.row].quantity > 0 {
            cartProductsDatasource.remove(at: indexPath.row)
            cartArray = cartProductsDatasource
            cartTableView.reloadData()
//            if cartProductsDatasource.count > 0 {
//            UserDefault.saveCartProducts(products: cartProductsDatasource)
//            }
        }
    }
}
