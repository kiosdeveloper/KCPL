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
        self.title = "My Cart"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    func configNavigationBar() {
        
//        let textAttributes = [NSAttributedStringKey.foregroundColor:ConstantsUI.C_Color_Title]
//        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    @IBAction func btnNextPressed(_ sender: Any) {
        if let cartArray = UserDefault.getCartProducts(), cartArray.count > 0 {
            for product in cartArray {
                if product.quantity == 0 {
                    "Quantity must be greater than 0".configToast(isError: true)
                    return
                }
            }
        }
        if !Util.isSalesApp() {
            self.performSegue(withIdentifier: "showDeliveryAddressFromCart", sender: nil)
        }
        else {
            self.performSegue(withIdentifier: "showCustomerListFromCart", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItemDetailFromCart" {
            if let toVC = segue.destination as? ItemDetailVC, let indexPath = sender as? IndexPath {
                toVC.title = cartProductsDatasource[indexPath.row].category_name
                toVC.product = cartProductsDatasource[indexPath.row]
            }
        }
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
            
            cell.setDataSource(product: cartProductsDatasource[indexPath.row])
            
            return cell
        } else {
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartTotalCell") as! CartTotalCell
            
            cell.setDataSource(products: self.cartProductsDatasource)
                        
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.performSegue(withIdentifier: "showItemDetailFromCart", sender: indexPath)
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
        
        if self.cartProductsDatasource[indexPath.row].quantity! < self.cartProductsDatasource[indexPath.row].available_quantity! {
            self.cartProductsDatasource[indexPath.row] = Util().plusQuantity(product: self.cartProductsDatasource[indexPath.row], quantity: nil)
            UIView.setAnimationsEnabled(false)
            self.cartTableView.reloadRows(at: [indexPath], with: .none)
            let totalIndexPath = IndexPath(row: 0, section: 1)
            self.cartTableView.reloadRows(at: [totalIndexPath], with: .none)
        } else {
            "Out Of Stock".configToast(isError: true)
        }
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
    }
    
    func btnMinusQuantity(cell: CartCell) {
        guard let indexPath = self.cartTableView.indexPath(for: cell) else { return }
        
        if self.cartProductsDatasource[indexPath.row].quantity == 0 {
            if var cartArray_temp = UserDefault.getCartProducts() {
                
                if let i = cartArray_temp.index(where: { $0.id == self.cartProductsDatasource[indexPath.row].id }) {
                    cartArray_temp.remove(at: i)
                    self.cartProductsDatasource.remove(at: indexPath.row)
                    
                    if (cartProductsDatasource.count > 0) {
                        self.cartTableView.deleteRows(at: [indexPath], with: .middle)
                    } else {
                        let lastSectionIndexPath = IndexPath(row: 0, section: 1)
                        self.cartTableView.deleteRows(at: [indexPath,lastSectionIndexPath], with: .middle)
                    }
                    
                    
                }
                
                UserDefault.saveCartProducts(products: cartArray_temp)
            }
//            cartTableView.reloadData()

            return
        }
        
        if let product = Util().minusQuantity(product: self.cartProductsDatasource[indexPath.row]) {
            self.cartProductsDatasource[indexPath.row] = product
            
            if product.quantity == 0 {
                if var cartArray_temp = UserDefault.getCartProducts() {
                    
                    if let i = cartArray_temp.index(where: { $0.id == product.id }) {
                        cartArray_temp.remove(at: i)
                        self.cartProductsDatasource.remove(at: indexPath.row)
                        
                        if (cartProductsDatasource.count > 0) {
                            self.cartTableView.deleteRows(at: [indexPath], with: .middle)
                        } else {
                            let lastSectionIndexPath = IndexPath(row: 0, section: 1)
                            self.cartTableView.deleteRows(at: [indexPath,lastSectionIndexPath], with: .middle)
                        }
                    }
                    
                    UserDefault.saveCartProducts(products: cartArray_temp)
                }
            } else {
                UIView.setAnimationsEnabled(false)
                cartTableView.reloadRows(at: [indexPath], with: .none)
                let totalIndexPath = IndexPath(row: 0, section: 1)
                self.cartTableView.reloadRows(at: [totalIndexPath], with: .none)
            }
        }
        
//        cartTableView.reloadData()
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
                
                if (cartProductsDatasource.count > 0) {
                    self.cartTableView.deleteRows(at: [indexPath], with: .middle)
                } else {
                    let lastSectionIndexPath = IndexPath(row: 0, section: 1)
                    self.cartTableView.deleteRows(at: [indexPath,lastSectionIndexPath], with: .middle)
                }
            }
            
            UserDefault.saveCartProducts(products: cartArray_temp)
        }
//        UIView.setAnimationsEnabled(false)
//        cartTableView.reloadData()
    }
}

//MARK: - TextFeild Delegate
extension CartVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        /*if textField.text! == "" || textField.text! == "0" {
            if var cartArray_temp = UserDefault.getCartProducts() {
                if let i = cartArray_temp.index(where: { $0.id == self.cartProductsDatasource[textField.tag].id }) {
                    self.cartProductsDatasource[textField.tag].quantity = 0
                    cartArray_temp.remove(at: i)
                }
                self.cartProductsDatasource.remove(at: textField.tag)
                UserDefault.saveCartProducts(products: cartArray_temp)
                if cartArray_temp.count == 0 {
                    UserDefault.removeCartProducts()
                }
                self.cartTableView.reloadData()
//                self.cartTableView.reloadRows(at: [indexPath], with: .none)
            }
            return
        }*/
        if let qtyString = textField.text, let qty = Int(qtyString) {
            self.cartProductsDatasource[textField.tag] = Util().plusQuantity(product: self.cartProductsDatasource[textField.tag], quantity: qty)
                UIView.setAnimationsEnabled(false)
                self.cartTableView.reloadRows(at: [IndexPath(item: 0, section: 1)], with: .none)
        } else {
            UIView.setAnimationsEnabled(false)
            self.cartTableView.reloadRows(at: [IndexPath(row: textField.tag, section: 0),IndexPath(item: 0, section: 1)], with: .none)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // For Length //
        guard let text = textField.text else { return true }
        
        if let newValue = Int(text+string), let availableProduct = self.cartProductsDatasource[textField.tag].available_quantity {
            if newValue == 0 {
                return false
            }
            return (newValue <= availableProduct)
        } else {
            return false
        }
    }
}
