//
//  AdminVendorViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 07/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminVendorViewController: UIViewController {
    
    @IBOutlet weak var vendorTableView: UITableView!
    
    let cellIdentifier = "VendorCustomerCell"
    
//    var contactNumberArray = ["9867122355", "8972376232", "8986123222", "8712638112", "8726378622"]
//    var companyNameArray = ["Shanghai Global Spares", "Southwest Global Spares", "India Steel Spares", "Shanghai Global Spares", "Southwest Global Spares"]
//    var gradeArray = ["A", "B", "C", "B", "A"]
    
    var vendorArray = [Vendor]()
    var filterVendorArray = [Vendor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vendorTableView.register(UINib.init(nibName: "VendorCustomerCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.view.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        self.configNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Vendors"
        self.getVendorList()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    func configNavigationBar() {
        let navPlus = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:  #selector(self.addVendorPressed))
        self.navigationItem.rightBarButtonItem = navPlus
    }
    
    //    MARK:- Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAdminCustomerVendorDetailFromAdminVendor" {
            if let toVC = segue.destination as? AdminCustomerVendorDetailViewController, let indexPath = sender as? IndexPath {
                toVC.fromScreenType = ScreenType.AdminVendorScreen
                toVC.vendor = self.filterVendorArray[indexPath.row]
            }
        }
    }
    
    //MARK: Action
    
    @IBAction func addVendorPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showAdminAddVendorFromAdminVendor", sender: nil)
    }
}

//MARK:- Helper Method
extension AdminVendorViewController {
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

extension AdminVendorViewController: UISearchBarDelegate {
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

extension AdminVendorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterVendorArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! VendorCustomerCell
        
        cell.setDataSource(vendor: self.filterVendorArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showAdminCustomerVendorDetailFromAdminVendor", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
