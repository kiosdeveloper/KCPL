//
//  AdminCustomerViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 09/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminCustomerViewController: UIViewController {
    
    @IBOutlet var sBar: ThemeSearchBar!
    @IBOutlet weak var customerTableView: UITableView!
    
    let cellIdentifier = "VendorCustomerCell"
    
//    var contactNumberArray = ["9867122355", "8972376232", "8986123222", "8712638112", "8726378622"]
//    var companyNameArray = ["Shanghai Global Spares", "Southwest Global Spares", "India Steel Spares", "Shanghai Global Spares", "Southwest Global Spares"]
//    var gradeArray = ["A", "B", "C", "B", "A"]
    var customerArray = [Customers]()
    var filterCustomerArray = [Customers]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customerTableView.register(UINib.init(nibName: "VendorCustomerCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.view.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        self.configNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Customers"
        self.getCustomerList()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
        self.sBar.resignFirstResponder()
    }
    
    func configNavigationBar() {
        let navPlus = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:  #selector(self.addCustomerPressed))
        self.navigationItem.rightBarButtonItem = navPlus
    }
    
//    MARK:- Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAdminCustomerVendorDetailFromAdminCustomer" {
            if let toVC = segue.destination as? AdminCustomerVendorDetailViewController, let indexPath = sender as? IndexPath {
                toVC.fromScreenType = ScreenType.AdminCustomerScreen
                toVC.customer = self.filterCustomerArray[indexPath.row]
            }
        }
    }
    
    //MARK: Action
    
    @IBAction func addCustomerPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showAddCustomerFromAdminCustomer", sender: nil)
    }
}

//MARK:- Helper Method
extension AdminCustomerViewController {
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

extension AdminCustomerViewController: UISearchBarDelegate {
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

extension AdminCustomerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterCustomerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! VendorCustomerCell
        
        cell.setDataSource(customer: self.filterCustomerArray[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showAdminCustomerVendorDetailFromAdminCustomer", sender: indexPath)
    }
}
