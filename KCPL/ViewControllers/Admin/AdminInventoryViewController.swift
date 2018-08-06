//
//  AdminInventoryViewController.swift
//  KCPL
//
//  Created by Piyush Sanepara on 07/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminInventoryViewController: AbstractVC {
    
    @IBOutlet var sBar: ThemeSearchBar!
    @IBOutlet var inventoryTableview: UITableView!
    
    @IBOutlet var headerView: ThemeShadowView!
    
    @IBOutlet weak var filterByCategoryTextfeild: UITextField!
    @IBOutlet weak var filterByBrandNameTextfeild: UITextField!
    
    @IBOutlet var actionButton: ThemeButtonForInventory!
    
    @IBOutlet var actionButtonWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet var selectButtonWidthConstraint: NSLayoutConstraint!
    
    var productsDatasource = [Product]()
    var filteredProductsDatasource = [Product]()
    var searchingProductsDatasource = [Product]()
    var isSearching = false
    
    var selectedProducts = [Product]()
    var selectedCustomerId: Int?
    
    var fromScreenType: ScreenType?
    
    var categoryArray = [String]()
    var brandNameArray = [String]()
    var selectedCategoryName = ""
    var selectedBrandName = ""
    var pickerFilter = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerView.layer.borderColor = ConstantsUI.C_Color_Theme.cgColor
        self.headerView.layer.borderWidth = 1.0
        
        inventoryTableview.register(UINib.init(nibName: "InventoryTableViewCell", bundle: nil), forCellReuseIdentifier: "InventoryTableViewCell")
        self.configPicker()
        
        self.configActionButton()
        self.getProductList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Inventory"
        self.filterArray()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
        self.sBar.resignFirstResponder()
    }
    
    func configPicker() {
        
        pickerFilter = UIPickerView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 216.0))
        pickerFilter.backgroundColor = UIColor.white
        
        self.filterByCategoryTextfeild.inputView = pickerFilter
        self.filterByCategoryTextfeild.delegate = self
        self.filterByBrandNameTextfeild.inputView = pickerFilter
        self.filterByBrandNameTextfeild.delegate = self
        
        pickerFilter.dataSource = self
        pickerFilter.delegate = self
    }
    
    func configActionButton() {
        
        if Util.isSalesApp() {
            actionButtonWidthConstraint.constant = -58
            selectButtonWidthConstraint.constant = -58
        } else {
            actionButtonWidthConstraint.constant = 50
            selectButtonWidthConstraint.constant = 50
        }
        
        self.actionButton.setTitle(((self.fromScreenType == nil) ? "Action" : "NEXT"), for: .normal)
    }
    
//    MARK:- Action
    @IBAction func ActionPressed(_ sender: Any) {
        
        if let screenType = self.fromScreenType {//Not From Inventory
            
            self.makeOrder(from: screenType)
            return
        }
        
        let actionSheet = UIAlertController(title: "Select Action", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Make Sales Order", style: .default, handler: { (action) in

            self.makeOrder(from: ScreenType.AdminSelectCustomerScreen)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Make Purchase Order", style: .default, handler: { (action) in
            
            self.makeOrder(from: ScreenType.AdminSelectVendorScreen)
            
//            self.performSegue(withIdentifier: "showAdminCartFromAdminInventory", sender: ScreenType.PurchaseScreen)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func makeOrder(from screenType: ScreenType) {
        
        self.selectedProducts.removeAll()
        
        self.selectedProducts = self.productsDatasource.filter { (product) -> Bool in
            
            if (product.available_quantity ?? 0 > 0) {
                product.quantity = 1
            } else {
                product.quantity = 0
            }
            
            return product.isSelect ?? false
        }
        
//        print(self.selectedProducts)
        
        if self.selectedProducts.count > 0 {
            
            if selectedCustomerId == nil {
                if screenType == ScreenType.AdminSelectCustomerScreen {
                    self.performSegue(withIdentifier: "showAdminSelectCustomerFromAdminInventory", sender: screenType)
                } else {
                    self.performSegue(withIdentifier: "showAdminSelectVendorFromAdminInventory", sender: screenType)
                }
                
            } else {
                self.performSegue(withIdentifier: "showAdminCartFromAdminInventory", sender: screenType)
            }
        } else {
            "Please select any product".configToast(isError: true)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAdminCartFromAdminInventory" {
                
            if let toVC = segue.destination as? AdminCartViewController, let screenType = sender as? ScreenType {
                toVC.fromScreenType = screenType
                toVC.cartProductsDatasource = self.selectedProducts
                toVC.selectedCustomerId = self.selectedCustomerId
            }
        } else if segue.identifier == "showAdminSelectCustomerFromAdminInventory" {
            
            if let toVC = segue.destination as? AdminSelectCustomerViewController, let screenType = sender as? ScreenType {
                toVC.cartProductsDatasource = self.selectedProducts
            }
        } else if segue.identifier == "showAdminSelectVendorFromAdminInventory" {
            
            if let toVC = segue.destination as? AdminSelectVendorViewController, let screenType = sender as? ScreenType {
                toVC.cartProductsDatasource = self.selectedProducts
            }
        }
        
    }
    
}

//MARK:- Helper Method
extension AdminInventoryViewController {
    func getProductList() {
        
        ServiceManager().processService(urlRequest: (Util.isSalesApp() ? ComunicateService.Router.GetInventorySales() : ComunicateService.Router.GetProductList_Admin())) { (isSuccess, error , responseData) in
            if isSuccess {
//                print(responseData)
                ServiceManagerModel().processProducts(json: responseData, completion: { (isComplete, products) in
                    if isComplete {
                        self.productsDatasource = products!
                        self.getBrandName_CategoryArray()
                        self.inventoryTableview.reloadData()
                    } else {
                        
                    }
                })
            } else {
                error?.configToast(isError: true)
            }
        }
    }
    
    func getBrandName_CategoryArray() {
        self.categoryArray.removeAll()
        self.categoryArray.append("All Categories")
        
        self.brandNameArray.removeAll()
        self.brandNameArray.append("All brands")
        
        for product in self.productsDatasource {
            
            if let brandName =  product.brand_name, !self.brandNameArray.contains(brandName) {
                self.brandNameArray.append(brandName)
            }
            
            if let categoryName =  product.category_name, !self.categoryArray.contains(categoryName) {
                self.categoryArray.append(categoryName)
            }
        }
    }
    
    func filterArray() {
        
        if self.selectedCategoryName != "", self.selectedBrandName != "" {
            self.filteredProductsDatasource = self.productsDatasource.filter { (product) -> Bool in
                (product.category_name!.lowercased().contains(self.selectedCategoryName.lowercased())) ? (product.brand_name!.lowercased().contains(self.selectedBrandName.lowercased())) : false
            }
        } else if self.selectedCategoryName != "" {
            self.filteredProductsDatasource = self.productsDatasource.filter({($0.category_name!.lowercased().contains(self.selectedCategoryName.lowercased()))})
        } else if self.selectedBrandName != "" {
            self.filteredProductsDatasource = self.productsDatasource.filter({($0.brand_name!.lowercased().contains(self.selectedBrandName.lowercased()))})
        }
        
        self.inventoryTableview.reloadData()
    }
    
    func refreshMainDatasource(index: Int) {
        if let i = productsDatasource.index(where: { $0.id == self.filteredProductsDatasource[index].id }) {
            self.productsDatasource[i] = self.filteredProductsDatasource[index]
        }
    }
    
    func refreshSearchMainDatasource(index: Int) {
        
        if selectedCategoryName != "" || selectedBrandName != "" {
            if let i = filteredProductsDatasource.index(where: { $0.id == self.searchingProductsDatasource[index].id }) {
                self.filteredProductsDatasource[i] = self.searchingProductsDatasource[index]
            }
            self.refreshMainDatasource(index: index)
        } else {
            if let i = productsDatasource.index(where: { $0.id == self.searchingProductsDatasource[index].id }) {
                self.productsDatasource[i] = self.searchingProductsDatasource[index]
            }
        }
    }
}

//MARK:- SearchBar
extension AdminInventoryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchingProductsDatasource.removeAll()
        
        if selectedCategoryName != "" || selectedBrandName != "" {//filtered
            if searchText.count > 0 {
                self.searchingProductsDatasource = self.filteredProductsDatasource.filter({($0.name?.lowercased().contains(searchText.lowercased()))!})
                isSearching = true
            } else {
                isSearching = false
            }
            self.inventoryTableview.reloadData()
        } else {//not filtered
            if searchText.count > 0 {
                self.searchingProductsDatasource = self.productsDatasource.filter({($0.name?.lowercased().contains(searchText.lowercased()))!})
                isSearching = true
            } else {
                isSearching = false
//                self.searchingProductsDatasource = self.productsDatasource
            }
            self.inventoryTableview.reloadData()
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = ((searchBar.text?.count)! > 0)
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        Util().configBarButtonColor(color: UIColor.white)
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.filteredProductsDatasource = self.customerArray
        
//        if selectedCategoryName != "" || selectedBrandName != "" {//filtered
//
//        } else {// Not Filtered
//
//        }
//
//        self.inventoryTableview.reloadData()
        isSearching = false
        self.inventoryTableview.reloadData()
        searchBar.text = nil
        Util().configBarButtonColor(color: UIColor.clear)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}

//MARK:- TableView
extension AdminInventoryViewController: UITableViewDelegate, UITableViewDataSource, InventoryTableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return self.searchingProductsDatasource.count
        } else {
            if selectedCategoryName != "" || selectedBrandName != "" {
                return self.filteredProductsDatasource.count
            } else {
                return productsDatasource.count
            }
        }
        
//        return productsDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = inventoryTableview.dequeueReusableCell(withIdentifier: "InventoryTableViewCell") as! InventoryTableViewCell
        
        cell.delegate = self
//        cell.configCellUI(fromScreenType: fromScreenType)
        
        if isSearching {
            cell.setDataSource(product: self.searchingProductsDatasource[indexPath.row])
        } else {
            if selectedCategoryName != "" || selectedBrandName != "" {
                cell.setDataSource(product: self.filteredProductsDatasource[indexPath.row])
            } else {
                cell.setDataSource(product: self.productsDatasource[indexPath.row])
            }
        }
        
        cell.configCellUISales()
//        cell.setDataSource(product: self.productsDatasource[indexPath.row])
        return cell
    }
    
    func isSelectButton(cell: InventoryTableViewCell) {
        guard let indexPath = self.inventoryTableview.indexPath(for: cell) else { return }
        
        if isSearching {
            if let isselect = self.searchingProductsDatasource[indexPath.row].isSelect {
                self.searchingProductsDatasource[indexPath.row].isSelect = !isselect
            }
            
            self.refreshSearchMainDatasource(index: indexPath.row)
            
        } else {
            if selectedCategoryName != "" || selectedBrandName != "" {
                if let isselect = self.filteredProductsDatasource[indexPath.row].isSelect {
                    self.filteredProductsDatasource[indexPath.row].isSelect = !isselect
                }
                
                self.refreshMainDatasource(index: indexPath.row)
                
            } else {
                if let isselect = self.productsDatasource[indexPath.row].isSelect {
                    self.productsDatasource[indexPath.row].isSelect = !isselect
                }
            }
        }
        
        self.inventoryTableview.reloadRows(at: [indexPath], with: .none)
    }
}

//MARK: - PICKER VIEW
extension AdminInventoryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        switch pickerFilter.tag {
        case 101:
            return categoryArray.count
        case 102:
            return brandNameArray.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerFilter.tag {
        case 101:
            selectedCategoryName = (row == 0) ? "" : categoryArray[row]
            //            txtAcademicYear.text = acamedicYearListSource[row].academicYear
            break
        case 102:
            selectedBrandName = (row == 0) ? "" : brandNameArray[row]
            //            txtYearGroup.text = yearGroupListSource[row].yeargroup
            break
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: "Helvetica", size: 18)
        label.textAlignment = NSTextAlignment.center
        
        switch pickerFilter.tag {
        case 101:
            label.text = categoryArray[row]
            break
        case 102:
            label.text = brandNameArray[row]
            break
        default:
            break
        }
        
        
        return label
    }
}

//MARK: - TextFeild Delegate
extension AdminInventoryViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == self.filterByBrandNameTextfeild {
//
//            if let i = brandNameArray.index(where: { $0 == selectedBrandName }) {
//                pickerFilter.selectRow(i, inComponent: 0, animated: true)
//            } else {
//                pickerFilter.selectRow(0, inComponent: 0, animated: true)
//            }
//        }
        
        switch textField {
        case self.filterByCategoryTextfeild:
            if categoryArray.count > 0 {
                pickerFilter.tag = 101
                pickerFilter.reloadAllComponents()
                
                if let i = categoryArray.index(where: { $0 == selectedCategoryName }) {
                    pickerFilter.selectRow(i, inComponent: 0, animated: true)
                } else {
                    pickerFilter.selectRow(0, inComponent: 0, animated: true)
                }
                
            } else {
                pickerFilter.tag = 0
            }
            
            break
        case self.filterByBrandNameTextfeild:
            if brandNameArray.count > 0 {
                pickerFilter.tag = 102
                pickerFilter.reloadAllComponents()
                
                if let i = brandNameArray.index(where: { $0 == selectedBrandName }) {
                    pickerFilter.selectRow(i, inComponent: 0, animated: true)
                } else {
                    pickerFilter.selectRow(0, inComponent: 0, animated: true)
                }
            } else {
                pickerFilter.tag = 0
            }
            
            break
        default:
            break
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        switch textField {
        case filterByCategoryTextfeild:
            self.filterByCategoryTextfeild.text = (selectedCategoryName == "") ? "All Categories" : selectedCategoryName
            
            self.filterArray()
            break
        case filterByBrandNameTextfeild:
            self.filterByBrandNameTextfeild.text = (selectedBrandName == "") ? "All brands" : selectedBrandName
            
            self.filterArray()
            break
        default:
            break
        }
    }
    
}

//MARK:- SideMenu
extension AdminInventoryViewController: SlideNavigationControllerDelegate {
    
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool
    {
        return !Util.isAdminApp()
    }
}
