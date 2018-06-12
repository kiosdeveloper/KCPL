//
//  AdminCartViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 09/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminCartViewController: UIViewController {
    
    @IBOutlet var cartTableView: UITableView!
    var fromScreenType: ScreenType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = ConstantsUI.C_Color_ThemeLightGray

        cartTableView.register(UINib.init(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "CartCell")
        cartTableView.register(UINib.init(nibName: "CartTotalCell", bundle: nil), forCellReuseIdentifier: "CartTotalCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if fromScreenType == ScreenType.SalesScreen {
            self.title = "Sales Order"
        } else if fromScreenType == ScreenType.PurchaseScreen {
            self.title = "Purchase Order"
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
//    MARK:- Action
    
    @IBAction func NextPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showAdminDeliveryAddressFromAdminCart", sender: nil)
    }
}

extension AdminCartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartCell") as! CartCell
            return cell
        } else {
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartTotalCell") as! CartTotalCell
            return cell
        }
        
    }
    
}
