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
    
    var companyNameArray = ["Hill Top Technologies", "Karnavati Corp. Pvt. Ltd.", "Majumdar Spares"]
    var addressArray = ["Ahmedabad, Gujarat", "Vadodara, Gujarat", "Baroda, Gujarat", "Surat, Gujarat", "Bharuch, Gujarat"]
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vendorTableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.view.backgroundColor = ConstantsUI.C_Color_White
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Select Vendor"
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //    MARK:- ACTIONS
    
    @IBAction func NextPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showAdminInventoryFromAdminSelectVendor", sender: nil)
    }
}

extension AdminSelectVendorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.companyNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! VendorCell
        cell.addressLabel.text = self.addressArray[indexPath.row]
        cell.companyNameLabel.text = self.companyNameArray[indexPath.row]
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
