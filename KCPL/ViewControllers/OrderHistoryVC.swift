//
//  OrderHistoryVC.swift
//  KCPL
//
//  Created by Aayushi Panchal on 04/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class OrderHistoryVC: AbstractVC {

    @IBOutlet weak var orderHistoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderHistoryTableView.reloadData()

    }

}

//MARK:- SideMenu
extension OrderHistoryVC: SlideNavigationControllerDelegate {
    
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool
    {
        return true
    }
}

extension OrderHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderHistoryCell") as! OrderHistoryTableViewCell
        
        if indexPath.row == 0 {
            cell.confirmButton.layer.borderColor = UIColor.init(red: 11.0/255.0, green: 92.0/255.0, blue: 174.0/255.0, alpha: 1.0).cgColor
            cell.confirmButton.setTitleColor(UIColor.init(red: 11.0/255.0, green: 92.0/255.0, blue: 174.0/255.0, alpha: 1.0), for: .normal)
        }
        else if indexPath.row == 1 {
            cell.confirmButton.layer.borderColor = UIColor.init(red: 243.0/255.0, green: 180.0/255.0, blue: 170.0/255.0, alpha: 1.0).cgColor
            cell.confirmButton.setTitleColor(UIColor.init(red: 243.0/255.0, green: 180.0/255.0, blue: 170.0/255.0, alpha: 1.0), for: .normal)
        }
        else {
            cell.confirmButton.layer.borderColor = UIColor.init(red: 0/255.0, green: 255.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
            cell.confirmButton.setTitleColor(UIColor.init(red: 0/255.0, green: 255.0/255.0, blue: 0.0/255.0, alpha: 1.0), for: .normal)
        }
        cell.confirmButton.layer.borderWidth = 1.0

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
