//
//  AdminCartViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 09/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminCartViewController: UIViewController {
    
    @IBOutlet var cartTableView: UITableView!
    @IBOutlet weak var nextButton: ThemeButton!
    
    var fromScreenType: ScreenType?
    var cartProductsDatasource = [Product]()
    var selectedCustomerId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        
        UserDefault.removeCartProducts()
        for product in self.cartProductsDatasource {
            _ = Util().plusQuantity(product: product, quantity: 1)
        }
        
        if let cartArray_temp = UserDefault.getCartProducts() {
            cartProductsDatasource = cartArray_temp
        }
        
        cartTableView.register(UINib.init(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "CartCell")
        cartTableView.register(UINib.init(nibName: "CartTotalCell", bundle: nil), forCellReuseIdentifier: "CartTotalCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if fromScreenType == ScreenType.AdminSelectCustomerScreen {
            self.title = "Sales Order"
        } else if fromScreenType == ScreenType.AdminSelectVendorScreen {
            self.title = "Purchase Order"
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    //    MARK:- Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAdminDeliveryAddressFromAdminCart" {
            if let toVC = segue.destination as? DeliveryAddressVC {
                toVC.userId = self.selectedCustomerId ?? 0
                toVC.fromScreenType = fromScreenType
            }
        }
    }
    
//    MARK:- Action
    
    @IBAction func NextPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showAdminDeliveryAddressFromAdminCart", sender: nil)
    }
}

extension AdminCartViewController: UITableViewDelegate, UITableViewDataSource, CartQuantityDelegate {
    
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
            
            cell.setDataSource(product: self.cartProductsDatasource[indexPath.row])
            
            return cell
        } else {
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartTotalCell") as! CartTotalCell
            
            cell.setDataSource(products: self.cartProductsDatasource)
            
            return cell
        }
    }
    
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
                        
                        if (cartProductsDatasource.count > 0) {
                            self.cartTableView.deleteRows(at: [indexPath], with: .middle)
                            UIView.setAnimationsEnabled(false)
                            self.cartTableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .none)
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
    }
    
    func btnRemoveFromCart(cell: CartCell) {
        guard let indexPath = self.cartTableView.indexPath(for: cell) else { return }
        if var cartArray_temp = UserDefault.getCartProducts() {
            
            if let i = cartArray_temp.index(where: { $0.id == self.cartProductsDatasource[indexPath.row].id }) {
                cartArray_temp.remove(at: i)
                self.cartProductsDatasource.remove(at: indexPath.row)
                
                if (cartProductsDatasource.count > 0) {
                    self.cartTableView.deleteRows(at: [indexPath], with: .middle)
                    
                    UIView.setAnimationsEnabled(false)
                    self.cartTableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .none)
                    
                } else {
                    let lastSectionIndexPath = IndexPath(row: 0, section: 1)
                    self.cartTableView.deleteRows(at: [indexPath,lastSectionIndexPath], with: .middle)
                }
            }
            
            UserDefault.saveCartProducts(products: cartArray_temp)
        }
        
//        cartTableView.reloadData()
    }
    
}

//MARK: - TextFeild Delegate
extension AdminCartViewController: UITextFieldDelegate {
    
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
            }
            return
        }*/ // Because If qty = 5 and I entered 6 then textfeild invalidate then I pressed Done so that is removing from cart instead of previous value of qty in cart
        
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
//        let newLength = text.count + string.count - range.length
        
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
