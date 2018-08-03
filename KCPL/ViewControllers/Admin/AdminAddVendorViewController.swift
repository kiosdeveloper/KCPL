//
//  AdminAddVendorViewController.swift
//  KCPL
//
//  Created by Piyush Sanepara on 11/07/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminAddVendorViewController: UIViewController {

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var addressLine1TextField: UITextField!
    @IBOutlet var addressLine2TextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var stateTextField: UITextField!
    @IBOutlet var zipTextField: UITextField!
    @IBOutlet var countryTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    
    let textFieldDelegate = CommonTextFieldDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.firstNameTextField.delegate = textFieldDelegate
        self.lastNameTextField.delegate = textFieldDelegate
        self.emailTextField.delegate = textFieldDelegate
        self.addressLine1TextField.delegate = textFieldDelegate
        self.addressLine2TextField.delegate = textFieldDelegate
        self.cityTextField.delegate = textFieldDelegate
        self.stateTextField.delegate = textFieldDelegate
        self.countryTextField.delegate = textFieldDelegate
        self.phoneTextField.delegate = textFieldDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Add Vendor"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""
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
            
        else if self.addressLine1TextField.text == "" {
            Constant.c_error_address_line1.configToast(isError: true)
            return false
        }
            
        else if self.addressLine2TextField.text == "" {
            Constant.c_error_address_line2.configToast(isError: true)
            return false
        }
            
        else if self.cityTextField.text == "" {
            Constant.c_error_city.configToast(isError: true)
            return false
        }
            
        else if self.stateTextField.text == "" {
            Constant.c_error_state.configToast(isError: true)
            return false
        }
            
        else if self.zipTextField.text == "" {
            Constant.c_error_zip.configToast(isError: true)
            return false
        }
            
        else if self.countryTextField.text == "" {
            Constant.c_error_country.configToast(isError: true)
            return false
        }
            
        else if self.phoneTextField.text == "" {
            Constant.c_error_mobile.configToast(isError: true)
            return false
        }
            
        else if (self.phoneTextField.text?.count)! < 9 {
            Constant.c_error_mobile.configToast(isError: true)
            return false
        }
       
        return true
    }
    
//    MARK:- Actions
    @IBAction func AddVendorButtonPressed(_ sender: Any) {
        if isAllFieldValid() {
            self.addVendor()
        }
    }
    
}

extension AdminAddVendorViewController {
    func addVendor() {
        let params: [String: Any] = [
            Constant.c_req_vendor_name: "\(self.firstNameTextField.text ?? "") \(self.lastNameTextField.text ?? "")",
            Constant.c_req_vendor_email: self.emailTextField.text ?? "",
            Constant.c_req_vendor_address_line_1: self.addressLine1TextField.text ?? "",
            Constant.c_req_vendor_address_line_2: self.addressLine2TextField.text ?? "",
            Constant.c_req_vendor_city: self.cityTextField.text ?? "",
            Constant.c_req_vendor_state: self.stateTextField.text ?? "",
            Constant.c_req_vendor_zip: self.zipTextField.text ?? "",
            Constant.c_req_vendor_country: self.countryTextField.text ?? "",
            Constant.c_req_vendor_phone_no: self.phoneTextField.text ?? ""
        ]
        
        ServiceManager().processService(urlRequest: ComunicateService.Router.AddVendor(params)) { (isSuccess, error , responseData) in
            if isSuccess {
                self.navigationController?.popViewController(animated: true)
            } else {
                error?.configToast(isError: true)
            }
        }
    }
    
}

extension AdminAddVendorViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.zipTextField {
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            
            if let newValue = Int(text+string) {
                return (newValue < 1000000 && newLength <= 6)
            } else {
                return false
            }
            
        } else {
            return true
        }
    }
}
