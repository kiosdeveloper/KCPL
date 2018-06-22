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
        
        if let cartArray_temp = UserDefault.getCartProducts() {
            cartProductsDatasource = cartArray_temp
        }
        
        cartTableView.register(UINib.init(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "CartCell")
        cartTableView.register(UINib.init(nibName: "CartTotalCell", bundle: nil), forCellReuseIdentifier: "CartTotalCell")
        
        self.view.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        self.configNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Cart"
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    func configNavigationBar() {
        
//        let textAttributes = [NSAttributedStringKey.foregroundColor:ConstantsUI.C_Color_Title]
//        navigationController?.navigationBar.titleTextAttributes = textAttributes
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
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartCell") as! CartCell
            cell.delegate = self
            cell.productQuantityTextfeild.delegate = self
            cell.productQuantityTextfeild.tag = indexPath.row
            
            cell.productNameLabel.text = cartProductsDatasource[indexPath.row].name
            
            if let price = cartProductsDatasource[indexPath.row].price {
                cell.productPriceLabel.text = "₹ \(price)"
            }
            if let qty = cartProductsDatasource[indexPath.row].quantity {
                cell.productQuantityTextfeild.text = "\(qty)"
            }            
            
            return cell
        } else {
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartTotalCell") as! CartTotalCell
            
            var subtotle = 0
            var tax = 0.0
            
            for cartProduct in cartProductsDatasource {
                if let qty = cartProduct.quantity {
                    if let productPrice = cartProduct.price {
                        subtotle += (productPrice * qty)
                    }
                    
                    if let productGST = cartProduct.tax {
                        tax += (productGST * Double(qty))
                    }
                }
            }
            
            cell.subTotalLable.text = "₹ \(subtotle)"
            cell.gstLabel.text = "₹ \(tax)"
            cell.totalLabel.text = "₹ \(Double(subtotle) + tax)"
            
            return cell
        }
    }
    
    /*func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
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
    }*/
    
    func btnPlusQuantity(cell: CartCell) {
        guard let indexPath = self.cartTableView.indexPath(for: cell) else { return }
        
        print("+ \(indexPath.row) pressed")
        
        self.cartProductsDatasource[indexPath.row] = Util().plusQuantity(product: self.cartProductsDatasource[indexPath.row], quantity: nil)
        /*
        if let qty = cartProductsDatasource[indexPath.row].quantity {
            cartProductsDatasource[indexPath.row].quantity = qty + 1
        }
        
        if let cartArray_temp = UserDefault.getCartProducts() {
            for cart in cartArray_temp  where cart.id == cartProductsDatasource[indexPath.row].id {
                cart.quantity = cartProductsDatasource[indexPath.row].quantity
                UserDefault.saveCartProducts(products: cartArray_temp)
            }
        }*/
        
        self.cartTableView.reloadData()
    }
    
    func btnMinusQuantity(cell: CartCell) {
        guard let indexPath = self.cartTableView.indexPath(for: cell) else { return }
        
        if let product = Util().minusQuantity(product: self.cartProductsDatasource[indexPath.row]) {
            self.cartProductsDatasource[indexPath.row] = product
            
            if product.quantity == 0 {
                if var cartArray_temp = UserDefault.getCartProducts() {
                    
                    if let i = cartArray_temp.index(where: { $0.id == product.id }) {
                        cartArray_temp.remove(at: i)
                        self.cartProductsDatasource.remove(at: indexPath.row)
                    }
                    
                    UserDefault.saveCartProducts(products: cartArray_temp)
                }
            }
        }
        
        cartTableView.reloadData()
        /*
        if self.cartProductsDatasource[indexPath.row].quantity! > 0 {
            cartProductsDatasource[indexPath.row].quantity! -= 1
            
            if self.cartProductsDatasource[indexPath.row].quantity == 0 {
                if var cartArray_temp = UserDefault.getCartProducts() {
                    for (index, cart) in cartArray_temp.enumerated() where cart.id == cartProductsDatasource[indexPath.row].id {
                        cartArray_temp.remove(at: index)
                    }
                    UserDefault.saveCartProducts(products: cartArray_temp)
                }
                
            } else {
                if let cartArray_temp = UserDefault.getCartProducts() {
                    for cart in cartArray_temp {
                        if cart.id == cartProductsDatasource[indexPath.row].id {
                            cart.quantity = cartProductsDatasource[indexPath.row].quantity
                        }
                    }
                    UserDefault.saveCartProducts(products: cartArray_temp)
                }
            }
            cartTableView.reloadData()
        }*/
    }
    
    func btnRemoveFromCart(cell: CartCell) {
        guard let indexPath = self.cartTableView.indexPath(for: cell) else { return }
        if var cartArray_temp = UserDefault.getCartProducts() {
            
            if let i = cartArray_temp.index(where: { $0.id == self.cartProductsDatasource[indexPath.row].id }) {
                cartArray_temp.remove(at: i)
                self.cartProductsDatasource.remove(at: indexPath.row)
            }
            
            UserDefault.saveCartProducts(products: cartArray_temp)
        }
        
        cartTableView.reloadData()
//        if let qty = self.cartProductsDatasource[indexPath.row].quantity {
//
//
//        }
    }
}

//MARK: - TextFeild Delegate
extension CartVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let qtyString = textField.text, let qty = Int(qtyString) {
            self.cartProductsDatasource[textField.tag] = Util().plusQuantity(product: self.cartProductsDatasource[textField.tag], quantity: qty)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // For Length //
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        
        if let newValue = Int(text+string) {
            return (newValue < 1000 && newLength <= 3)
        } else {
            return false
        }
    }
}
