//
//  ProductListVC.swift
//  KCPL
//
//  Created by Piyush Sanepara on 29/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class ProductListVC: AbstractVC {

    @IBOutlet weak var productlistTableView: ThemeTableView!
    
    @IBOutlet weak var filterByTextfeild: UITextField!
    var productsDatasource = [Product]()
    var filteredProductsDatasource = [Product]()
    
    var category: Category?
    var pickerFilter = UIPickerView()
    var brandNameArray = [String]()
    var selectedBrandName = ""
    var categoryId: Int!
    
    var navCart = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configPicker()
        self.view.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        
//        self.getProductList()
        self.configNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.getProductList()
//        self.productlistTableView.reloadData()
        self.updateBadge()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = self.category?.name!
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    func getBrandNameArray() {
        self.brandNameArray.removeAll()
        self.brandNameArray.append("All brand")
        
        for product in self.productsDatasource where product.brand_name != nil {
            if !self.brandNameArray.contains(product.brand_name!) {
                self.brandNameArray.append(product.brand_name!)
            }
        }
    }
    
    func refreshMainDatasource(index: Int) {
        if let i = productsDatasource.index(where: { $0.id == self.filteredProductsDatasource[index].id }) {
            self.productsDatasource[i] = self.filteredProductsDatasource[index]
        }
    }
    
    func updateBadge() {
        if let cartArray_temp = UserDefault.getCartProducts(), cartArray_temp.count > 0 {
            navCart.addBadge(number: cartArray_temp.count)
        } else {
            navCart.removeBadge()
        }
    }
    
    func configNavigationBar() {
        
//        let textAttributes = [NSAttributedStringKey.foregroundColor:ConstantsUI.C_Color_Title]
//        navigationController?.navigationBar.titleTextAttributes = textAttributes

        navCart = UIBarButtonItem(image: UIImage(named: "nav_cart"), style: .plain, target: self, action: #selector(DashboardVC.navCartPressed))
        self.navigationItem.rightBarButtonItems = [navCart]
    }
    
    func configPicker() {
        self.filterByTextfeild.addRightSubView()
        
        pickerFilter = UIPickerView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 216.0))
        pickerFilter.backgroundColor = UIColor.white
        
        self.filterByTextfeild.inputView = pickerFilter
        
        pickerFilter.dataSource = self
        pickerFilter.delegate = self
    }
    
    @objc func navProfilePressed() {
        
    }
    
    @objc func navCartPressed() {
        self.performSegue(withIdentifier: "showCartFromProductList", sender: nil)
    }
    
}

extension ProductListVC {
    func getProductList() {
        ServiceManager().processService(urlRequest: ComunicateService.Router.GetProductList(categoryId: self.categoryId)) { (isSuccess, error , responseData) in
            if isSuccess {
                ServiceManagerModel().processProducts(json: responseData, completion: { (isComplete, products) in
                    if isComplete {
                        
                        if let cartArray_temp = UserDefault.getCartProducts() {
                            for product in products! {
                                if let i = cartArray_temp.index(where: { $0.id == product.id }) {

                                    product.quantity = cartArray_temp[i].quantity
                                }
                            }
                        }
                        self.productsDatasource = products!
                        if self.selectedBrandName != "" {// If already filtered...
                            self.filteredProductsDatasource = self.productsDatasource.filter({($0.brand_name!.lowercased().contains(self.selectedBrandName.lowercased()))})
                        } else {
                            self.filteredProductsDatasource = self.productsDatasource
                        }
                        
                        self.getBrandNameArray()
                        self.productlistTableView.delegate = self
                        self.productlistTableView.dataSource = self
                        
                        self.productlistTableView.reloadData()
                    } else {
                    }
                })
            } else {
                error?.configToast(isError: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItemDetailFromProductList" {
            if let toVC = segue.destination as? ItemDetailVC, let indexPath = sender as? IndexPath {
                toVC.title = self.category?.name
                toVC.product = filteredProductsDatasource[indexPath.row]
            }
        }
    }
}

extension ProductListVC: UITableViewDelegate, UITableViewDataSource, ProductListDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.productlistTableView.isHidden = !(filteredProductsDatasource.count > 0)
        return filteredProductsDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = productlistTableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell") as! ProductListTableViewCell
        
        cell.productNameLabel.text = filteredProductsDatasource[indexPath.row].name
        if let price = filteredProductsDatasource[indexPath.row].price {
            cell.productPriceLabel.text = "₹ \(price)"
        }
        cell.delegate = self
        cell.quantityTextField.delegate = self
        cell.quantityTextField.tag = indexPath.row
        
        if let qty = filteredProductsDatasource[indexPath.row].quantity {
            cell.quantityTextField.text = "\(qty)"
//            cell.addToCartButton.isHidden = qty > 0
//            cell.addToCartButton.setTitle((qty > 0) ? "Added" : "Add to Cart", for: .normal)
            
            if qty > 0 {
                cell.addToCartButton.isDisableConfig()
                cell.addToCartButton.setTitle("Added", for: .normal)
            } else {
                cell.addToCartButton.isEnableConfig()
                cell.addToCartButton.setTitle("Add to Cart", for: .normal)
            }
            
        }
        
        cell.productImageView.sd_setImage(with: URL.init(string: self.filteredProductsDatasource[indexPath.row].imageUrl!), placeholderImage: UIImage(named: "item_detail"), options: .fromCacheOnly, completed: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showItemDetailFromProductList", sender: indexPath)
    }
    
    //    MARK:- Action
    
    @IBAction func NextPressed(_ sender: Any) {
//        self.performSegue(withIdentifier: "showCartFromProductList", sender: nil)
    }
    
    func btnPlusQuantity(cell: ProductListTableViewCell) {
         guard let indexPath = self.productlistTableView.indexPath(for: cell) else { return }
        
        self.filteredProductsDatasource[indexPath.row] = Util().plusQuantity(product: self.filteredProductsDatasource[indexPath.row], quantity: nil)
        
        self.refreshMainDatasource(index: indexPath.row)
        
        /*if let qty = self.productsDatasource[indexPath.row].quantity {
            self.productsDatasource[indexPath.row].quantity = qty + 1
        }
        
        if let cartArray_temp = UserDefault.getCartProducts() {
            for cart in cartArray_temp  where cart.id == productsDatasource[indexPath.row].id {
                cart.quantity = productsDatasource[indexPath.row].quantity
            }
            UserDefault.saveCartProducts(products: cartArray_temp)
        }*/
        
        self.updateBadge()
        self.productlistTableView.reloadData()

        
    }
    
    func btnMinusQuantity(cell: ProductListTableViewCell) {
        guard let indexPath = self.productlistTableView.indexPath(for: cell) else { return }
        
        if let product = Util().minusQuantity(product: self.filteredProductsDatasource[indexPath.row]) {
            self.filteredProductsDatasource[indexPath.row] = product
            
            self.refreshMainDatasource(index: indexPath.row)
            
            if product.quantity == 0 {
                if var cartArray_temp = UserDefault.getCartProducts() {
                   
                    if let i = cartArray_temp.index(where: { $0.id == product.id }) {
                        cartArray_temp.remove(at: i)
                    }
                    
                    UserDefault.saveCartProducts(products: cartArray_temp)
                }
            }
        }
        
        /*
        if let qty = self.productsDatasource[indexPath.row].quantity, qty > 0 {
            self.productsDatasource[indexPath.row].quantity = qty - 1
            
            if self.productsDatasource[indexPath.row].quantity == 0 {
                if var cartArray_temp = UserDefault.getCartProducts() {
                    for (index, cart) in cartArray_temp.enumerated() where cart.id == productsDatasource[indexPath.row].id {
                        cartArray_temp.remove(at: index)
                    }
                    UserDefault.saveCartProducts(products: cartArray_temp)
                }
                
            } else {
                if let cartArray_temp = UserDefault.getCartProducts() {
                    for cart in cartArray_temp {
                        if cart.id == productsDatasource[indexPath.row].id {
                            cart.quantity = productsDatasource[indexPath.row].quantity
                        }
                    }
                    UserDefault.saveCartProducts(products: cartArray_temp)
                }
            }
        }*/
        self.updateBadge()
        self.productlistTableView.reloadData()
    }
    
    func btnAddToCart(cell: ProductListTableViewCell) {
        guard let indexPath = self.productlistTableView.indexPath(for: cell) else { return }
        
        self.filteredProductsDatasource[indexPath.row] = Util().plusQuantity(product: self.filteredProductsDatasource[indexPath.row], quantity: nil)
        
        self.refreshMainDatasource(index: indexPath.row)
        
        /*if let qty = self.productsDatasource[indexPath.row].quantity {
            self.productsDatasource[indexPath.row].quantity = qty + 1
        }
        
        let product = Product(product: self.productsDatasource[indexPath.row], quantity: 1)
        
        if var cartArray_temp = UserDefault.getCartProducts() {
            cartArray_temp.append(product)

            UserDefault.saveCartProducts(products: cartArray_temp)
        } else {
            var cartArray_temp = [Product]()
            cartArray_temp.append(product)

//                cartArray_temp.last?.quantity += 1
            UserDefault.saveCartProducts(products: cartArray_temp)
        }*/
        
        self.productlistTableView.reloadData()
        self.updateBadge()
    }
}

//MARK: - PICKER VIEW
extension ProductListVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return brandNameArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("You select \(row)")
        if row == 0 {
            selectedBrandName = ""
        } else {
            selectedBrandName = self.brandNameArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: "Helvetica", size: 18)
        label.textAlignment = NSTextAlignment.center
        
        label.text = brandNameArray[row]
        
        return label
    }
}

//MARK: - TextFeild Delegate
extension ProductListVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.filterByTextfeild {
            
            if let i = brandNameArray.index(where: { $0 == selectedBrandName }) {
                pickerFilter.selectRow(i, inComponent: 0, animated: true)
            } else {
                pickerFilter.selectRow(0, inComponent: 0, animated: true)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.filterByTextfeild {
            self.filterByTextfeild.text = "Filter By " + selectedBrandName
            
            self.filteredProductsDatasource.removeAll()
            if selectedBrandName == "" {
                self.filteredProductsDatasource = self.productsDatasource
                self.productlistTableView.reloadData()
            } else {
                self.filteredProductsDatasource = self.productsDatasource.filter({($0.brand_name!.lowercased().contains(selectedBrandName.lowercased()))})
                self.productlistTableView.reloadData()
            }
            
            
            
        } else {
            if let qtyString = textField.text, let qty = Int(qtyString) {
                self.filteredProductsDatasource[textField.tag] = Util().plusQuantity(product: self.filteredProductsDatasource[textField.tag], quantity: qty)
                
                self.productlistTableView.reloadData()
                self.updateBadge()
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.filterByTextfeild {
            return true
        } else {
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
}
