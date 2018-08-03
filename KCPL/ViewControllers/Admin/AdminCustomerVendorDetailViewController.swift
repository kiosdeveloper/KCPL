//
//  AdminCustomerVendorDetailViewController.swift
//  KCPL
//
//  Created by Piyush Sanepara on 11/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminCustomerVendorDetailViewController: UIViewController {
    
    @IBOutlet weak var customerDetailTableView: UITableView!
    var fromScreenType: ScreenType?
    var customer: Customers?
    var vendor: Vendor?
    
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

extension AdminCustomerVendorDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if fromScreenType == ScreenType.AdminCustomerScreen {
            return self.customer != nil ? 1 : 0
        } else if fromScreenType == ScreenType.AdminVendorScreen {
            return self.vendor != nil ? 1 : 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerVendorDetailCell") as! CustomerVendorDetailCell
        
        if fromScreenType == ScreenType.AdminCustomerScreen {
            cell.setDataSource(customer: self.customer)
        } else {
            cell.setDataSource(vendor: self.vendor)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

