//
//  AdminSelectCustomerViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 09/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminSelectCustomerViewController: UIViewController {
    
    @IBOutlet var sBar: ThemeSearchBar!
    @IBOutlet weak var customerTableView: UITableView!
    
    let cellIdentifier = "SelectCustomerCell"
    
    var customerArray = [Customers]()
    var filterCustomerArray = [Customers]()
    
    var selectedIndex = 0
    
    var cartProductsDatasource = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customerTableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.view.backgroundColor = ConstantsUI.C_Color_White
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Select Customer"
        self.getCustomerList()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
        self.sBar.resignFirstResponder()
    }
    
    //    MARK:- Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAdminInventoryFromAdminSelectCustomer" {
            if let toVC = segue.destination as? AdminInventoryViewController {
                toVC.selectedCustomerId = self.filterCustomerArray[self.selectedIndex].customerId
                toVC.fromScreenType = ScreenType.AdminSelectCustomerScreen
            }
        } else if segue.identifier == "showAdminCartFromAdminSelectCustomer" {
            if let toVC = segue.destination as? AdminCartViewController {
                toVC.selectedCustomerId = self.filterCustomerArray[self.selectedIndex].customerId
                toVC.fromScreenType = ScreenType.AdminSelectCustomerScreen
                toVC.cartProductsDatasource = self.cartProductsDatasource
            }
        }
        
    }
    
//    MARK:- ACTIONS
    @IBAction func NextPressed(_ sender: Any) {
        if cartProductsDatasource.count > 0 { //Cart Done Already So Open Cart Directly...
            self.performSegue(withIdentifier: "showAdminCartFromAdminSelectCustomer", sender: nil)
        } else {
            self.performSegue(withIdentifier: "showAdminInventoryFromAdminSelectCustomer", sender: nil)
        }
    }
}

//MARK:- Helper Method
extension AdminSelectCustomerViewController {
    func getCustomerList() {
        ServiceManager().processService(urlRequest: ComunicateService.Router.GetCustomerList()) { (isSuccess, error , responseData) in
            if isSuccess {
                ServiceManagerModel().processCustomers(json: responseData, completion: { (isComplete, customers) in
                    if isComplete {
                        self.customerArray = customers!
                        self.filterCustomerArray = self.customerArray
                        
                        self.customerTableView.reloadData()
                    } else {
                        
                    }
                })
            } else {
                error?.configToast(isError: true)
            }
        }
    }
}

extension AdminSelectCustomerViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterCustomerArray.removeAll()
        
        if searchText.count > 0 {
            self.filterCustomerArray = self.customerArray.filter { (customer) -> Bool in
                if customer.firstName == nil, customer.lastName == nil {
                    return "\(customer.name ?? "")".lowercased().contains(searchText.lowercased())
                } else {
                    return "\(customer.firstName ?? "")  \(customer.lastName ?? "")".lowercased().contains(searchText.lowercased())
                }
            }
            
            self.customerTableView.reloadData()
        }
        else {
            self.filterCustomerArray = self.customerArray
            self.customerTableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        Util().configBarButtonColor(color: UIColor.white)
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.filterCustomerArray = self.customerArray
        self.customerTableView.reloadData()
        
        searchBar.text = nil
        Util().configBarButtonColor(color: UIColor.clear)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}

extension AdminSelectCustomerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterCustomerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! SelectCustomerCell
        
        let customer = self.filterCustomerArray[indexPath.row]
        
        cell.contactNumberLabel.text = customer.phone ?? ""
        
        if customer.firstName == nil, customer.lastName == nil {
            cell.companyNameLabel.text = customer.name ?? ""
        } else {
            cell.companyNameLabel.text = "\(customer.firstName ?? "")  \(customer.lastName ?? "")"
        }
        
//        cell.gradeLabel.text = "A"
        
        if selectedIndex == indexPath.row {
            cell.selectCustomerImageView.image = #imageLiteral(resourceName: "radioOn")
        }
        else {
            cell.selectCustomerImageView.image = #imageLiteral(resourceName: "radioOff")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.item
        self.customerTableView.reloadData()
    }
}

