//
//  DeliveryAddressVC.swift
//  KCPL
//
//  Created by Aayushi Panchal on 10/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

protocol DeliveryAddressDelegate: class {
    func needToReload()
}

class DeliveryAddressVC: AbstractVC {
    
    @IBOutlet weak var deliveryAddressTableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var TableviewBottomConstraints: NSLayoutConstraint!
    
    var delegate: DeliveryAddressDelegate?
    
    var isFromMenu = false
    var addressDatasource = [Address]()
    var selectedIndex = -1
    var isEditAddress = false
    var isAddAddress = false
    var userId: Int = 0
    var fromScreenType: ScreenType?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.deliveryAddressTableView.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        
        deliveryAddressTableView.register(UINib.init(nibName: "DeliveryAddressCell", bundle: nil), forCellReuseIdentifier: "DeliveryAddressCell")
        
        self.configNavigationBar()
        nextButton.isHidden = isFromMenu
        
        if isFromMenu {
            TableviewBottomConstraints.constant = -(nextButton.frame.size.height)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = isFromMenu ? "My Address" : "Choose delivery address"
        self.getAddressList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }

    func configNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Add"), style: .plain, target: self, action: #selector(addAddressClicked))
    }
    
    @objc func addAddressClicked() {
        print("Add Address")
        self.isAddAddress = true
        self.isEditAddress = false
        self.performSegue(withIdentifier: "showAddUpdateAddressFromAddressList", sender: nil)
    }
    
//    MARK:- Actions
    @IBAction func nextClicked(_ sender: Any) {
        if self.selectedIndex == -1 {
            "Please select one address".configToast(isError: false)
            return
        }
        let alertController = UIAlertController.init(title: "Confirm", message: "Are you sure you want to place this order?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (alertAction) in
            
            self.createOrder()
            
        }))
        alertController.addAction(UIAlertAction.init(title: "Cancel", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddUpdateAddressFromAddressList" {
            if let toVC = segue.destination as? AddUpdateAddressVC {
               toVC.userId = self.userId
               toVC.isAddAddress = self.isAddAddress
                toVC.address = self.isEditAddress ? self.addressDatasource[self.selectedIndex] : nil
            }
        }
    }
}
extension DeliveryAddressVC: SlideNavigationControllerDelegate {
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool
    {
        return self.isFromMenu
    }
}

//MARK:- Helper Method
extension DeliveryAddressVC {
    func getAddressList() {
        if userId == 0, let user_id = UserDefault.getUser()?.id {
            userId = user_id
        }
        ServiceManager().processService(urlRequest: ComunicateService.Router.GetAddressList(userId: self.userId)) { (isSuccess, error , responseData) in
            if isSuccess {
                ServiceManagerModel().processAddressList(json: responseData, completion: { (isComplete, address) in
                    if isComplete {
                        self.addressDatasource = address!
                        self.deliveryAddressTableView.reloadData()
                    }
                    else {
                        
                    }
                })
            } else {
                error?.configToast(isError: true)
            }
        }
    }
    
    func createOrder() {
        let address = self.addressDatasource[self.selectedIndex]

        let line1 = "\(address.line1 ?? "")" + " "
        let line2 = "\(address.line2 ?? "")" + ", " + "\n"
        let city = "\(address.city ?? "")" + ", "
        let state = "\(address.state ?? "")" + " - "
        let zipcode = "\(address.zipcode ?? 0)" + "\n"
        let country = "\(address.country ?? "")"
        
        let orderAddress =  line1 + line2 + city + state + zipcode + country
        
        var params: [String: Any] = [:]
        if self.fromScreenType == .AdminSelectVendorScreen  { // Purchase order
            params = [
                Constant.c_req_purchase_ship_by_address: orderAddress,
                Constant.c_req_purchase_vendor_id: self.userId 
            ]
            
            if let cartArray = UserDefault.getCartProducts() {
                for (index,item) in cartArray.enumerated() {
                    params["\(Constant.c_req_purchase_products_attributes)[\(index+1)][product_id]"] = item.id
                    params["\(Constant.c_req_purchase_products_attributes)[\(index+1)][qty]"] = item.quantity
                }
            }
            
            self.createOrderPurchase(params: params)
        } else { //Sales order
            params = [
                Constant.c_req_ship_by_address: orderAddress,
                Constant.c_req_bill_to_address: orderAddress,
                Constant.c_req_ship_to_address: orderAddress,
                Constant.c_req_customer_id: address.user_id ?? ""
            ]
            
            if let cartArray = UserDefault.getCartProducts() {
                for (index,item) in cartArray.enumerated() {
                    params["\(Constant.c_req_sorder_products_attributes)[\(index+1)][product_id]"] = item.id
                    params["\(Constant.c_req_sorder_products_attributes)[\(index+1)][qty]"] = item.quantity
                }
            }
            
            self.createOrderSales(params: params)
        }
        
        
//        print(params)
        
        
    }
    
    func createOrderSales(params: [String: Any]) {
        ServiceManager().processService(urlRequest: ComunicateService.Router.CreateOrder(params)) { (isSuccess, error , responseData) in
            if isSuccess {
                print(responseData!)
                
                for viewController in (self.navigationController?.viewControllers ?? []) {
                    if viewController is DashboardVC {
                        UserDefault.removeCartProducts()
                        "Your order placed successfully.".configToast(isError: false)
                        
                        _ = self.navigationController?.popToViewController(viewController, animated: true)
                        
                        return
                    }
                    
                    if Util.isAdminApp(), viewController is AdminSalesViewController {
                        
                        self.delegate = viewController as? DeliveryAddressDelegate
                        
                        self.delegate?.needToReload()
                        UserDefault.removeCartProducts()
                        "Your order placed successfully.".configToast(isError: false)
                        _ = self.navigationController?.popToViewController(viewController, animated: true)
                        return
                    }
                    
                    /*if Util.isAdminApp(), viewController is AdminPurchaseViewController {
                        UserDefault.removeCartProducts()
                        "Your order placed successfully.".configToast(isError: false)
                        
                        _ = self.navigationController?.popToViewController(viewController, animated: true)
                        
                        return
                    }*/
                }
                if Util.isAdminApp() {
                    for viewController in (self.navigationController?.viewControllers ?? []) where viewController is AdminDashboardVC {
                        UserDefault.removeCartProducts()
                        "Your order placed successfully.".configToast(isError: false)
                        
                        _ = self.navigationController?.popToViewController(viewController, animated: true)
                        
                        return
                    }
                }
                
            } else {
                error?.configToast(isError: true)
            }
        }
    }
    
    func createOrderPurchase(params: [String: Any]) {
        ServiceManager().processService(urlRequest: ComunicateService.Router.CreatePurchaseOrder(params)) { (isSuccess, error , responseData) in
            if isSuccess {
                print(responseData!)
                
                for viewController in (self.navigationController?.viewControllers ?? []) {
                    if viewController is DashboardVC {
                        UserDefault.removeCartProducts()
                        "Your order placed successfully.".configToast(isError: false)
                        
                        _ = self.navigationController?.popToViewController(viewController, animated: true)
                        
                        return
                    }
                    
                    if Util.isAdminApp(), viewController is AdminPurchaseViewController {
                        
                        self.delegate = viewController as? DeliveryAddressDelegate
                        
                        self.delegate?.needToReload()
                        UserDefault.removeCartProducts()
                        "Your order placed successfully.".configToast(isError: false)
                        
                        _ = self.navigationController?.popToViewController(viewController, animated: true)
                        
                        return
                    }
                    
                }// end for loop
                if Util.isAdminApp() {
                    for viewController in (self.navigationController?.viewControllers ?? []) where viewController is AdminDashboardVC {
                        UserDefault.removeCartProducts()
                        "Your order placed successfully.".configToast(isError: false)
                        
                        _ = self.navigationController?.popToViewController(viewController, animated: true)
                        
                        return
                    }
                }
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
        
        return self.addressDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = deliveryAddressTableView.dequeueReusableCell(withIdentifier: "DeliveryAddressCell") as! DeliveryAddressCell
        let address = self.addressDatasource[indexPath.row]
        
        cell.companyNameLabel.text = ""
        
        let line1 = "\(address.line1 ?? "")" + " "
        let line2 = "\(address.line2 ?? "")" + ", " + "\n"
        let city = "\(address.city ?? "")" + ", "
        let state = "\(address.state ?? "")" + " - "
        let zipcode = "\(address.zipcode ?? 0)" + "\n"
        let country = "\(address.country ?? "")"
        
        cell.addressLabel.text = line1 + line2 + city + state + zipcode + country
        
        if let user = UserDefault.getUser(), let fName = user.first_name, let lname = user.last_name {
            cell.userNameLabel.text = fName + " " + lname
            
            if let phone = user.phone {
                cell.userNumberLabel.text = phone
            }
        }
        cell.selectButtonWidthConstraint.constant = self.isFromMenu ? 0 : 30
        cell.selectButton.isHidden = self.isFromMenu
        cell.selectButton.isSelected = self.selectedIndex == indexPath.row
        cell.delegate = self
        cell.editButton.isHidden = Util.isSalesApp()
        cell.edtiButtonWidthConstraint.constant = Util.isSalesApp() ?  0 : 30
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return titleLabel
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }*/
}

extension DeliveryAddressVC: AddressListDelegate {
    func editAddress(cell: DeliveryAddressCell) {
        guard let indexPath = self.deliveryAddressTableView.indexPath(for: cell) else { return }
        self.selectedIndex = indexPath.row
        self.isAddAddress = false
        self.isEditAddress = true
        self.performSegue(withIdentifier: "showAddUpdateAddressFromAddressList", sender: nil)
    }
    
    func selectAddress(cell: DeliveryAddressCell) {
        guard let indexPath = self.deliveryAddressTableView.indexPath(for: cell) else { return }
        cell.selectButton.isSelected = !cell.selectButton.isSelected
        self.selectedIndex = indexPath.row
        self.deliveryAddressTableView.reloadData()
    }
    
    
}
