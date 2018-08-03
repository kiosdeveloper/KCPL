//
//  CustomerListVC.swift
//  KCPL
//
//  Created by Piyush Sanepara on 15/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class CustomerListVC: AbstractVC {
        
    @IBOutlet var titleView: UIView!
    
    @IBOutlet weak var customerTableView: UITableView!
    
    @IBOutlet weak var nextButton: ThemeButton!
    
    @IBOutlet weak var nextButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var searchBar: ThemeSearchBar!
    
    var customerArray = [Customers]()
    var filteredCustomerArray = [Customers]()
    var selectedIndex = 0
    var isFromMenu = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customerTableView.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        self.nextButton.isHidden = self.isFromMenu ? true : false
        self.nextButtonHeightConstraint.constant = self.isFromMenu ? 0 : 50
        self.configNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getCustomerList()
        self.title = "My Customers"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    func configNavigationBar() {
        let navPlus = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:  #selector(self.addCustomerClicked))
        self.navigationItem.rightBarButtonItem = navPlus
    }
    
    @IBAction func selectCutomerClicked(_ sender: UIButton) {
        self.selectedIndex = sender.tag
        self.customerTableView.reloadData()
    }
    
    @IBAction func addCustomerClicked(_ sender: ThemeButtonPlain) {
        self.performSegue(withIdentifier: "showAddCustomerFromCustomerList", sender: nil)
    }
    
    @IBAction func nextClicked(_ sender: ThemeButton) {
        self.performSegue(withIdentifier: "showAddressListFromCustomerList", sender: nil)
    }
    
}

extension CustomerListVC: SlideNavigationControllerDelegate {
    
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool
    {
        return self.isFromMenu
    }
}

extension CustomerListVC {
    //    MARK:- Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddressListFromCustomerList" {
            if let toVC = segue.destination as? DeliveryAddressVC {
                toVC.userId = self.filteredCustomerArray[self.selectedIndex].customerId ?? 0
            }
        }
    }
    
    func getCustomerList() {
        ServiceManager().processService(urlRequest: ComunicateService.Router.GetCustomerList()) { (isSuccess, error , responseData) in
            if isSuccess {
                ServiceManagerModel().processCustomers(json: responseData, completion: { (isComplete, customers) in
                    if isComplete {
                        self.customerArray = customers!
                        self.filteredCustomerArray = self.customerArray
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


extension CustomerListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.filteredCustomerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = customerTableView.dequeueReusableCell(withIdentifier: "CustomerTableViewCell") as! CustomerTableViewCell
        
        let customer = self.filteredCustomerArray[indexPath.row]
        cell.customerNameLabel.text = "\(customer.firstName ?? "")  \(customer.lastName ?? "")"
        cell.customerAddressLabel.text = customer.address ?? ""
        cell.customerNumberLabel.text = customer.phone ?? ""
        cell.customerEmailLabel.text = customer.email ?? ""
        cell.selectCustomerButton.isHidden = self.isFromMenu ? true : false
        cell.selectButtonWidthConstraint.constant = self.isFromMenu ? 0 : 30
        cell.selectCustomerButton.isSelected = self.selectedIndex == indexPath.row
        cell.selectCustomerButton.tag = indexPath.row
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return titleView
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
}

extension CustomerListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredCustomerArray.removeAll()
        
        if searchText.count > 0 {
            self.filteredCustomerArray = self.customerArray.filter { (user) -> Bool in
                return "\(user.firstName ?? "")  \(user.lastName ?? "")".lowercased().contains(searchText.lowercased()) || "\(user.email ?? "")".contains(searchText)
            }
            self.customerTableView.reloadData()
        }
        else {
            self.filteredCustomerArray = self.customerArray
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
        self.filteredCustomerArray = self.customerArray
        self.customerTableView.reloadData()

        searchBar.text = nil
        Util().configBarButtonColor(color: UIColor.clear)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
