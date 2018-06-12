//
//  AdminSelectCustomerViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 09/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminSelectCustomerViewController: UIViewController {
    
    @IBOutlet weak var customerTableView: UITableView!
    
    let cellIdentifier = "SelectCustomerCell"
    
    var contactNumberArray = ["9867122355", "8972376232", "8986123222", "8712638112", "8726378622"]
    var companyNameArray = ["Shanghai Global Spares", "Southwest Global Spares", "India Steel Spares", "Shanghai Global Spares", "Southwest Global Spares"]
    var gradeArray = ["A", "B", "C", "B", "A"]
    var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        customerTableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.view.backgroundColor = ConstantsUI.C_Color_White
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Select Customer"
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
//    MARK:- ACTIONS
    
    @IBAction func NextPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showAdminInventoryFromAdminSelectCustomer", sender: nil)
    }
}

extension AdminSelectCustomerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.companyNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! SelectCustomerCell
        cell.contactNumberLabel.text = self.contactNumberArray[indexPath.row]
        cell.companyNameLabel.text = self.companyNameArray[indexPath.row]
        cell.gradeLabel.text = self.gradeArray[indexPath.row]
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

