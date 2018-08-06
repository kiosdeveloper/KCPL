//
//  AdminSalesViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 07/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminSalesViewController: UIViewController, DeliveryAddressDelegate {

    @IBOutlet var sBar: ThemeSearchBar!
    @IBOutlet weak var salesTableView: UITableView!
    
    let cellIdentifier = "salesCell"
    
//    var orderNumberArray = ["3259A", "3289B", "3250C"]
//    var companyNameArray = ["Shanghai Global Spares \n Shanghai Global Spares", "Southwest Global Spares", "India Steel Spares"]
//    var timeArray = ["2 Hr. Ago", "6 Hr. Ago", "2 Days Ago"]

    var salesOrderDataSource = [Order]()
    var filterSalesOrderDataSource = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBar()
        self.getSalesOrder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Sales"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
        self.sBar.resignFirstResponder()
    }
    
    //    Delegate Method for reload
    func needToReload() {
        self.getSalesOrder()
    }
    
    func configNavigationBar() {
        let navPlus = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:  #selector(self.addSalesOrderPressed))
        self.navigationItem.rightBarButtonItem = navPlus
    }
    
//    MARK:- Action
    @IBAction func addSalesOrderPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showAdminSelectCustomerFromAdminDashBoard", sender: nil)
    }
    
//    MARK:- Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOrderHistoryDetailFromAdminSales" {
            if let toVC = segue.destination as? OrderHistoryDetailVC,let indexPath = sender as? IndexPath {
                toVC.orderDetail = filterSalesOrderDataSource[indexPath.row]
            }
        }
    }
}

extension AdminSalesViewController {
    func getSalesOrder() {
        ServiceManager().processService(urlRequest: ComunicateService.Router.GetOrderHistory()) { (isSuccess, error , responseData) in
            if isSuccess {
                ServiceManagerModel().processOrderList(json: responseData, completion: { (isComplete, order) in
                    if isComplete {
                        self.salesOrderDataSource = order!
                        self.filterSalesOrderDataSource = self.salesOrderDataSource
                        
                        self.salesTableView.reloadData()
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

extension AdminSalesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterSalesOrderDataSource.removeAll()
        
        if searchText.count > 0 {
            self.filterSalesOrderDataSource = self.salesOrderDataSource.filter { (order) -> Bool in
                if let user = order.user {
                    return "\(user.first_name ?? "")  \(user.last_name ?? "")".lowercased().contains(searchText.lowercased()) || "\(order.orderId ?? 0)".contains(searchText)
                }
                return "\(order.orderId ?? 0)".contains(searchText)
//                return false
            }
            
            self.salesTableView.reloadData()
        }
        else {
            self.filterSalesOrderDataSource = self.salesOrderDataSource
            self.salesTableView.reloadData()
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
        self.filterSalesOrderDataSource = self.salesOrderDataSource
        self.salesTableView.reloadData()
        
        searchBar.text = nil
        Util().configBarButtonColor(color: UIColor.clear)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}

extension AdminSalesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterSalesOrderDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! AdminSalesTableViewCell
        
        cell.setDataSource(order: self.filterSalesOrderDataSource[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showOrderHistoryDetailFromAdminSales", sender: indexPath)
    }
    
}
