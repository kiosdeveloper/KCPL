//
//  DeliveryAddressVC.swift
//  KCPL
//
//  Created by Aayushi Panchal on 10/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class DeliveryAddressVC: AbstractVC {
    
    @IBOutlet weak var deliveryAddressTableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.deliveryAddressTableView.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
    }
    
//    MARK:- Actions
    @IBAction func nextClicked(_ sender: Any) {
        let alertController = UIAlertController.init(title: "Confirm", message: "Are you sure you want to place this order?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (alertAction) in
            for viewController in (self.navigationController?.viewControllers ?? []) {
                if viewController is DashboardVC {
                    _ = self.navigationController?.popToViewController(viewController, animated: true)
                    return
                }
            }
        }))
        alertController.addAction(UIAlertAction.init(title: "Cancel", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension DeliveryAddressVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = deliveryAddressTableView.dequeueReusableCell(withIdentifier: "DeliveryAddressTableViewCell") as! DeliveryAddressTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return titleLabel
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
