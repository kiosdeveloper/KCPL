//
//  AddCustomerVC.swift
//  KCPL
//
//  Created by MacBook Pro on 01/07/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AddCustomerVC: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!

    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Customers"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "My Customers"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func addCustomerClicked(_ sender: ThemeButton) {
        if isAllFieldValid() {
            self.addCustomer()
        }
    }
}

extension AddCustomerVC {
    func addCustomer() {
        if let user = UserDefault.getUser(), let id = user.id {
            let uuid = NSUUID().uuidString.lowercased()
            let deviceGUID = UIDevice.current.identifierForVendor!.uuidString + uuid
            
            let params: [String: Any] = [
                Constant.c_req_first_name: self.firstNameTextField.text!,
                Constant.c_req_last_name: self.lastNameTextField.text!,
                Constant.c_req_customer_email: self.emailTextField.text!,
                Constant.c_req_customer_password: "kcpl_cust_\(id)",
                Constant.c_req_device_token: deviceGUID,
                Constant.c_req_device_type: "1",
                Constant.c_req_address: self.addressTextField.text!,
                Constant.c_req_phone: self.phoneNumberTextField.text!
            ]
            
            ServiceManager().processService(urlRequest: ComunicateService.Router.AddCustomer(params)) { (isSuccess, error , responseData) in
                if isSuccess {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    error?.configToast(isError: true)
                }
            }
        }
        
    }
    
    func isAllFieldValid() -> Bool {
        if self.firstNameTextField.text == "" {
            Constant.c_error_firstname.configToast(isError: true)
            return false
        }
            
        else if self.lastNameTextField.text == "" {
            Constant.c_error_lastname.configToast(isError: true)
            return false
        }
            
        else if self.emailTextField.text == "" {
            Constant.c_error_email.configToast(isError: true)
            return false
        }
            
        else if !(self.emailTextField.text!.isValidEmail()) {
            Constant.c_error_valid_email.configToast(isError: true)
            return false
        }
            
        else if self.phoneNumberTextField.text == "" {
            Constant.c_error_mobile.configToast(isError: true)
            return false
        }
            
        else if (self.phoneNumberTextField.text?.count)! < 9 {
            Constant.c_error_mobile.configToast(isError: true)
            return false
        }
        
        else if self.addressTextField.text == "" {
            Constant.c_error_customer_address.configToast(isError: true)
            return false
        }
        return true
    }
}
