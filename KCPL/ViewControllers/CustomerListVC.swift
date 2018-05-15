//
//  CustomerListVC.swift
//  KCPL
//
//  Created by Piyush Sanepara on 15/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class CustomerListVC: AbstractVC {
        
    @IBOutlet var titleView: UIView!
    
    @IBOutlet weak var customerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customerTableView.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        
    }
}

extension CustomerListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = customerTableView.dequeueReusableCell(withIdentifier: "CustomerTableViewCell") as! CustomerTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showCustomerDetailFromCustomerList", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return titleView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
