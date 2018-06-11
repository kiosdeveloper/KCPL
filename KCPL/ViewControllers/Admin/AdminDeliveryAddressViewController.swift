//
//  AdminDeliveryAddressViewController.swift
//  KCPL
//
//  Created by Piyush Sanepara on 11/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminDeliveryAddressViewController: UIViewController {
    
    @IBOutlet weak var deliveryAddressTableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.deliveryAddressTableView.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        
        deliveryAddressTableView.register(UINib.init(nibName: "DeliveryAddressCell", bundle: nil), forCellReuseIdentifier: "DeliveryAddressCell")
        
        self.configNavigationBar()
    }
    
    func configNavigationBar() {
        self.title = "Choose delivery address"
        let textAttributes = [NSAttributedStringKey.foregroundColor:ConstantsUI.C_Color_Title]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    //    MARK:- Actions
    @IBAction func nextClicked(_ sender: Any) {
        let alertController = UIAlertController.init(title: "Confirm", message: "Are you sure you want to place this order?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (alertAction) in
            for viewController in (self.navigationController?.viewControllers ?? []) {
                if viewController is AdminDashboardVC {
                    
                    "Your order placed successfully.".configToast(isError: false)
                    _ = self.navigationController?.popToViewController(viewController, animated: true)
                    return
                }
            }
        }))
        alertController.addAction(UIAlertAction.init(title: "Cancel", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension AdminDeliveryAddressViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = deliveryAddressTableView.dequeueReusableCell(withIdentifier: "DeliveryAddressCell") as! DeliveryAddressCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return titleLabel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
