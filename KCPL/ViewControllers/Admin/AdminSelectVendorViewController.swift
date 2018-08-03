//
//  AdminSelectVendorViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 09/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminSelectVendorViewController: UIViewController {
    
    @IBOutlet weak var vendorTableView: UITableView!
    
    let cellIdentifier = "VendorCell"
    
    var selectedIndex = 0
    
    var vendorArray = [Vendor]()
    var filterVendorArray = [Vendor]()

    override func viewDidLoad() {
        super.viewDidLoad()
        vendorTableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.view.backgroundColor = ConstantsUI.C_Color_White
        self.getVendorList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Select Vendor"
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    //    MARK:- Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAdminInventoryFromAdminSelectVendor" {
            if let toVC = segue.destination as? AdminInventoryViewController {
                toVC.selectedCustomerId = self.filterVendorArray[self.selectedIndex].vendorId
                toVC.fromScreenType = ScreenType.AdminSelectVendorScreen
            }
        }
    }
    
    //    MARK:- ACTIONS
    @IBAction func NextPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showAdminInventoryFromAdminSelectVendor", sender: nil)
    }
}

//MARK:- Helper Method
extension AdminSelectVendorViewController {
    func getVendorList() {
        ServiceManager().processService(urlRequest: ComunicateService.Router.GetVendorList()) { (isSuccess, error , responseData) in
            if isSuccess {
                ServiceManagerModel().processVendors(json: responseData, completion: { (isComplete, vendors) in
                    if isComplete {
                        self.vendorArray = vendors!
                        self.filterVendorArray = self.vendorArray
                        
                        self.vendorTableView.reloadData()
                    } else {
                        
                    }
                })
            } else {
                error?.configToast(isError: true)
            }
        }
    }
}

extension AdminSelectVendorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterVendorArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! VendorCell
        
        let vendor = self.filterVendorArray[indexPath.row]
        cell.addressLabel.text =  vendor.phone_no ?? ""
        if vendor.firstName == nil, vendor.lastName == nil {
            cell.companyNameLabel.text = vendor.name ?? ""
        } else {
            cell.companyNameLabel.text = "\(vendor.firstName ?? "")  \(vendor.lastName ?? "")"
        }
        if selectedIndex == indexPath.row {
            cell.radioImageView.image = #imageLiteral(resourceName: "radioOn")
        }
        else {
            cell.radioImageView.image = #imageLiteral(resourceName: "radioOff")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.item
        self.vendorTableView.reloadData()
    }
}

extension AdminSelectVendorViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterVendorArray.removeAll()
        
        if searchText.count > 0 {
            self.filterVendorArray = self.vendorArray.filter { (vendor) -> Bool in
                if vendor.firstName == nil, vendor.lastName == nil {
                    return "\(vendor.name ?? "")".lowercased().contains(searchText.lowercased())
                } else {
                    return "\(vendor.firstName ?? "")  \(vendor.lastName ?? "")".lowercased().contains(searchText.lowercased())
                }
            }
            
            self.vendorTableView.reloadData()
        }
        else {
            self.filterVendorArray = self.vendorArray
            self.vendorTableView.reloadData()
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
        self.filterVendorArray = self.vendorArray
        self.vendorTableView.reloadData()
        
        searchBar.text = nil
        Util().configBarButtonColor(color: UIColor.clear)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
