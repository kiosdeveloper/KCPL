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
    
    var category: Category?
    var pickerFilter = UIPickerView()
    var filterArray = ["Honda","Ceat","Mahindra","Tata"]
    var selectedFilter = ""
    var categoryId: Int!
    
    var navCart = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configPicker()
        
        self.getProductList()
        
        self.configNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateBadge()
    }
    
    func updateBadge() {
        if cartArray.count > 0 {
            navCart.addBadge(number: cartArray.count)
        } else {
            navCart.removeBadge()
        }
    }
    
    func configNavigationBar() {
        self.title = self.category?.name!
        let textAttributes = [NSAttributedStringKey.foregroundColor:ConstantsUI.C_Color_Title]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        let navProfile = UIBarButtonItem(image: UIImage(named: "nav_profile"), style: .plain, target: self, action: #selector(DashboardVC.navProfilePressed))
        
        navCart = UIBarButtonItem(image: UIImage(named: "nav_cart"), style: .plain, target: self, action: #selector(DashboardVC.navCartPressed))
        self.navigationItem.rightBarButtonItems = [navProfile, navCart]
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
                        self.productsDatasource = products!
                        
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
                toVC.product = productsDatasource[indexPath.row]
            }
        }
    }
}

extension ProductListVC: UITableViewDelegate, UITableViewDataSource, ProductListDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = productlistTableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell") as! ProductListTableViewCell
        
        cell.productNameLabel.text = productsDatasource[indexPath.row].name
        if let price = productsDatasource[indexPath.row].price {
            cell.productPriceLabel.text = "\(price) Rs."
        }
        cell.delegate = self
        cell.quantityTextField.tag = indexPath.row
        cell.quantityTextField.text = "\(productsDatasource[indexPath.row].quantity)"
        
        cell.productImageView.sd_setImage(with: URL.init(string: self.productsDatasource[indexPath.row].imageUrl!), placeholderImage: UIImage(named: "item_detail"), options: .fromCacheOnly, completed: nil)
        cell.addToCartButton.isHidden = productsDatasource[indexPath.row].quantity > 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showItemDetailFromProductList", sender: indexPath)
    }
    
    //    MARK:- Action
    func btnPlusQuantity(cell: ProductListTableViewCell) {
         guard let indexPath = self.productlistTableView.indexPath(for: cell) else { return }
        
        self.productsDatasource[indexPath.row].quantity += 1
        
        for cart in cartArray  where cart.id == productsDatasource[indexPath.row].id {
                cart.quantity = productsDatasource[indexPath.row].quantity
        }
        self.updateBadge()
        self.productlistTableView.reloadData()

        /*self.productsDatasource[sender.tag].quantity += 1
         print(self.productsDatasource)
         if let productListArray = UserDefaults.standard.value(forKey: "cartArray") as? [[String : Data]] {
         //            print(productListArray["product"] as! [Data])
         for product in productListArray {
         
         }
         //            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: productListArray["product"]) as! [Product]
         //            print(decodedTeams[0].name)
         }
         else {
         let product = NSKeyedArchiver.archivedData(withRootObject: self.productsDatasource[sender.tag])
         let dict = [["product\(self.productsDatasource[sender.tag].id)": product]] as [[String : Data]]
         UserDefaults.standard.set(dict, forKey: "cartArray")
         UserDefaults.standard.synchronize()
         } */
    }
    
    func btnMinusQuantity(cell: ProductListTableViewCell) {
        guard let indexPath = self.productlistTableView.indexPath(for: cell) else { return }

        if self.productsDatasource[indexPath.row].quantity > 0 {
            self.productsDatasource[indexPath.row].quantity -= 1
//            let product = Product(product: self.productsDatasource[indexPath.row], quantity: self.productsDatasource[indexPath.row].quantity)
            if self.productsDatasource[indexPath.row].quantity == 0 {
                for (index, cart) in cartArray.enumerated() where cart.id == productsDatasource[indexPath.row].id {
                    cartArray.remove(at: index)
                }
            } else {
                for cart in cartArray {
                    if cart.id == productsDatasource[indexPath.row].id {
                        cart.quantity = productsDatasource[indexPath.row].quantity
                    }
                }
            }
        }
        self.updateBadge()
        self.productlistTableView.reloadData()

        /*if self.productsDatasource[sender.tag].quantity > 0 {
         self.productsDatasource[sender.tag].quantity -= 1
         print(self.productsDatasource)
         }*/
    }
    
    func btnAddToCart(cell: ProductListTableViewCell) {
        guard let indexPath = self.productlistTableView.indexPath(for: cell) else { return }

        self.productsDatasource[indexPath.row].quantity += 1
        
        let product = Product(product: self.productsDatasource[indexPath.row], quantity: 1)
        cartArray.append(product)
        self.productlistTableView.reloadData()
        
            if var cartArray_temp = UserDefault.getCartProducts() {
                cartArray_temp.append(product)

    //            cartArray_temp.last?.quantity += 1

                UserDefault.saveCartProducts(products: cartArray_temp)
            } else {
                var cartArray_temp = [Product]()
                cartArray_temp.append(product)

    //                cartArray_temp.last?.quantity += 1
                UserDefault.saveCartProducts(products: cartArray_temp)
            }
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
        return filterArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("You select \(row)")
        selectedFilter = self.filterArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: "Helvetica", size: 18)
        label.textAlignment = NSTextAlignment.center
        
        label.text = filterArray[row]
        
        return label
    }
}

//MARK: - TextFeild Delegate
extension ProductListVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.filterByTextfeild {
            pickerFilter.selectRow(0, inComponent: 0, animated: true)
        }
        else {
            self.productsDatasource[textField.tag].quantity = Int(textField.text!)!
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.filterByTextfeild {
            self.filterByTextfeild.text = selectedFilter
        }
    }
}
