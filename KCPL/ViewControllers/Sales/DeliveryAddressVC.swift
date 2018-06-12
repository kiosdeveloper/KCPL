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
        
        deliveryAddressTableView.register(UINib.init(nibName: "DeliveryAddressCell", bundle: nil), forCellReuseIdentifier: "DeliveryAddressCell")
        
        self.configNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Choose delivery address"
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    func configNavigationBar() {
        
//        let textAttributes = [NSAttributedStringKey.foregroundColor:ConstantsUI.C_Color_Title]
//        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
//    MARK:- Actions
    @IBAction func nextClicked(_ sender: Any) {
        let alertController = UIAlertController.init(title: "Confirm", message: "Are you sure you want to place this order?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (alertAction) in
            
            self.createOrder()
            
        }))
        alertController.addAction(UIAlertAction.init(title: "Cancel", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK:- Helper Method
extension DeliveryAddressVC {
    func createOrder() {

        var params: [String: Any] = [
            Constant.c_req_ship_by_address: "Gandhinagar",
            Constant.c_req_bill_to_address: "Gandhinagar",
            Constant.c_req_ship_to_address: "Gandhinagar"
        ]
        
        if let cartArray = UserDefault.getCartProducts() {
            for (index,item) in cartArray.enumerated() {
                params["\(Constant.c_req_sorder_products_attributes)[\(index+1)][product_id]"] = item.id
                params["\(Constant.c_req_sorder_products_attributes)[\(index+1)][qty]"] = item.quantity
            }
        }
        
        print(params)
        
        ServiceManager().processService(urlRequest: ComunicateService.Router.CreateOrder(params)) { (isSuccess, error , responseData) in
            if isSuccess {
                print(responseData)
                
                for viewController in (self.navigationController?.viewControllers ?? []) {
                    if viewController is DashboardVC {
                        UserDefault.removeCartProducts()
                        "Your order placed successfully.".configToast(isError: false)
                        _ = self.navigationController?.popToViewController(viewController, animated: true)
                        return
                    }
                }
//                ServiceManagerModel().processLogin(json: responseData, completion: { (isComplete) in
//                    if isComplete {
//                        self.performSegue(withIdentifier: "showDashboardFromLogin", sender: nil)
//                    }
//                })
            } else {
                error?.configToast(isError: true)
            }
        }
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
