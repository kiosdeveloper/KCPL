//
//  AdminCustomerVendorViewController.swift
//  KCPL
//
//  Created by Piyush Sanepara on 11/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminCustomerVendorViewController: UIViewController {
    
    @IBOutlet weak var customerDetailTableView: UITableView!
    var fromScreenType: ScreenType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customerDetailTableView.estimatedRowHeight = 500.0
 
        customerDetailTableView.register(UINib.init(nibName: "CustomerVendorDetailCell", bundle: nil), forCellReuseIdentifier: "CustomerVendorDetailCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if fromScreenType == ScreenType.AdminCustomerScreen {
            self.title = "Customer Detail"
        } else if fromScreenType == ScreenType.AdminVendorScreen {
            self.title = "Vendor Detail"
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AdminCustomerVendorViewController: UITableViewDelegate, UITableViewDataSource {
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

