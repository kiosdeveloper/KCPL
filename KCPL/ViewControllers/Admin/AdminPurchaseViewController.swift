//
//  AdminPurchaseViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 07/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminPurchaseViewController: UIViewController,DeliveryAddressDelegate {
    
    @IBOutlet var sBar: ThemeSearchBar!
    
    @IBOutlet weak var purchaseTableView: UITableView!
    
    let cellIdentifier = "purchaseCell"
    
//    var orderNumberArray = ["3259A", "3289B", "3250C"]
//    var companyNameArray = ["Hill Top Technologies", "Karnavati Corp. Pvt. Ltd.", "Majumdar Spares"]
//    var timeArray = ["2 Hr. Ago", "3 Hr. Ago", "6 Hr. Ago"]
    
    var purchaseOrderDataSource = [Order]()
    var filterPurchaseOrderDataSource = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBar()
        self.getPurchaseOrder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Purchase"
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
        self.sBar.resignFirstResponder()
    }
    
    //    Delegate Method for reload
    func needToReload() {
        self.getPurchaseOrder()
    }
    
    func configNavigationBar() {
        let navPlus = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:  #selector(self.addPurchaseOrderPressed))
        self.navigationItem.rightBarButtonItem = navPlus
    }
    
    //    MARK:- Action
    @IBAction func addPurchaseOrderPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showAdminSelectVendorFromAdminPurchase", sender: nil)
    }
    
    //    MARK:- Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOrderHistoryDetailFromAdminPurchase" {
            if let toVC = segue.destination as? OrderHistoryDetailVC,let indexPath = sender as? IndexPath {
                toVC.orderDetail = filterPurchaseOrderDataSource[indexPath.row]
            }
        }
    }
}

extension AdminPurchaseViewController {
    func getPurchaseOrder() {
        ServiceManager().processService(urlRequest: ComunicateService.Router.GetPurchaseHistory()) { (isSuccess, error , responseData) in
            if isSuccess {
                ServiceManagerModel().processOrderList(json: responseData, completion: { (isComplete, order) in
                    if isComplete {
                        self.purchaseOrderDataSource = order!
                        self.filterPurchaseOrderDataSource = self.purchaseOrderDataSource

                        self.purchaseTableView.reloadData()
                    }
                    else {

                    }
                })
            } else {
                error?.configToast(isError: true)
            }
        }
    }
}

extension AdminPurchaseViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterPurchaseOrderDataSource.removeAll()
        
        if searchText.count > 0 {
            self.filterPurchaseOrderDataSource = self.purchaseOrderDataSource.filter { (order) -> Bool in
                if let user = order.user {
                    return "\(user.first_name ?? "")  \(user.last_name ?? "")".lowercased().contains(searchText.lowercased()) || "\(order.orderId ?? 0)".contains(searchText)
                }
                return "\(order.orderId ?? 0)".contains(searchText)
                //                return false
            }
            
            self.purchaseTableView.reloadData()
        }
        else {
            self.filterPurchaseOrderDataSource = self.purchaseOrderDataSource
            self.purchaseTableView.reloadData()
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
        self.filterPurchaseOrderDataSource = self.purchaseOrderDataSource
        self.purchaseTableView.reloadData()
        
        searchBar.text = nil
        Util().configBarButtonColor(color: UIColor.clear)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}

extension AdminPurchaseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterPurchaseOrderDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! AdminPurchaseTableViewCell
        
        cell.setDataSource(order: self.filterPurchaseOrderDataSource[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showOrderHistoryDetailFromAdminPurchase", sender: indexPath)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
}
