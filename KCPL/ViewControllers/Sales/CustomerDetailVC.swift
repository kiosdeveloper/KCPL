//
//  CustomerDetailVC.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 12/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class CustomerDetailVC: AbstractVC {

    @IBOutlet weak var customerDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customerDetailTableView.estimatedRowHeight = 500.0
        
        customerDetailTableView.register(UINib.init(nibName: "CustomerVendorDetailCell", bundle: nil), forCellReuseIdentifier: "CustomerVendorDetailCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CustomerDetailVC: SlideNavigationControllerDelegate {
    
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool
    {
        return false
    }
}

extension CustomerDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerVendorDetailCell") as! CustomerVendorDetailCell
        
        cell.companyNameLabel.text = "Karnavati Corp. Pvt. Ltd."
        cell.companyAddressLabel.text = "A 111 GIDC, Ramol\nSP Ring Road, Ahmedabad,\nGujarat-382356"
        
        cell.contactLabel.text = "987875645636"
        cell.emailLabel.text = "kcpl.admin@gmail.com"
        
        cell.personNameLabel.text = "Mr. Sahil"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
