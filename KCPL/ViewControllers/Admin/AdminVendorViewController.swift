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
    
    var contactNumberArray = ["9867122355", "8972376232", "8986123222", "8712638112", "8726378622"]
    var companyNameArray = ["Shanghai Global Spares", "Southwest Global Spares", "India Steel Spares", "Shanghai Global Spares", "Southwest Global Spares"]
    var gradeArray = ["A", "B", "C", "B", "A"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vendorTableView.register(UINib.init(nibName: "VendorCustomerCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.view.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        self.configNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Vendors"
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    func configNavigationBar() {
        let navPlus = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:  #selector(self.addVendorPressed))
        self.navigationItem.rightBarButtonItem = navPlus
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Action
    
    @IBAction func addVendorPressed(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAdminCustomerVendorFromAdminVendor" {
            if let toVC = segue.destination as? AdminCustomerVendorViewController, let indexPath = sender as? IndexPath {
                toVC.fromScreenType = ScreenType.AdminVendorScreen
            }
        }
    }
    
}

extension AdminVendorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.companyNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! VendorCustomerCell
        cell.contactNumberLabel.text = self.contactNumberArray[indexPath.row]
        cell.companyNameLabel.text = self.companyNameArray[indexPath.row]
        cell.gradeLabel.text = self.gradeArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showAdminCustomerVendorFromAdminVendor", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
