//
//  CartVC.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 05/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class CartVC: AbstractVC {

    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cartTableView.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
    }
    @IBAction func btnNextPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "showDeliveryAddressFromCart", sender: nil)
    }
    
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    
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
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartItemListCell") as! CartItemListCell
            
            return cell
        } else {
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartTotalCell") as! CartTotalCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return titleLabel
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        } else {
            return 0
        }
    }
}

//MARK:- SideMenu
extension CartVC: SlideNavigationControllerDelegate {
    
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool
    {
        return true
    }
}
