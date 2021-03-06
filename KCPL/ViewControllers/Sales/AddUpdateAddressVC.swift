//
//  AddUpdateAddressVC.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 16/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AddUpdateAddressVC: AbstractVC {

    @IBOutlet weak var line1TextField: AddressTextField!
    
    @IBOutlet weak var line2TextField: AddressTextField!
    
    @IBOutlet weak var cityTextField: AddressTextField!
    
    @IBOutlet weak var stateTextField: AddressTextField!
    
    @IBOutlet weak var countryTextField: AddressTextField!
    
    @IBOutlet weak var zipCodeTextField: AddressTextField!
    
    @IBOutlet weak var updateButton: ThemeButton!
    
    var userId: Int = 0
    var isAddAddress = false
    var address : Address?
    let textFieldDelegate = CommonTextFieldDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateButton.setTitle(isAddAddress ? "Add" : "Update", for: .normal)
        if let address = self.address {
            self.line1TextField.text = address.line1 ?? ""
            self.line2TextField.text = address.line2 ?? ""
            self.cityTextField.text = address.city ?? ""
            self.stateTextField.text = address.state ?? ""
            self.countryTextField.text = address.country ?? ""
            self.zipCodeTextField.text = "\(address.zipcode ?? 0)"
        }
        
        self.line1TextField.delegate = textFieldDelegate
        self.line2TextField.delegate = textFieldDelegate
        self.cityTextField.delegate = textFieldDelegate
        self.stateTextField.delegate = textFieldDelegate
        self.countryTextField.delegate = textFieldDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = isAddAddress ? "Add Address" : "Update Address"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    @IBAction func updateClicked(_ sender: ThemeButton) {
        if isValidAddress() {
            if self.isAddAddress {
                self.addAddress()
            }
            else {
                self.updateAddress()
            }
        }
        else {
            self.showAlert()
        }
    }
}

extension AddUpdateAddressVC {
    func isValidAddress() -> Bool {
        return (self.line1TextField.text?.count)! > 0 && (self.line2TextField.text?.count)! > 0 && (self.cityTextField.text?.count)! > 0 && (self.stateTextField.text?.count)! > 0 && (self.countryTextField.text?.count)! > 0 && (self.zipCodeTextField.text?.count)! > 0
    }
    
    func addAddress() {
        
        if userId == 0, let user_id = UserDefault.getUser()?.id {
           userId = user_id
        }
        
        ServiceManager().processService(urlRequest: ComunicateService.Router.AddAddress(self.getParams(), userId: userId)) { (isSuccess, error , responseData) in
            if isSuccess {
                print(responseData!)
                "Your Address added successfully.".configToast(isError: false)
                self.navigationController?.popViewController(animated: true)

            } else {
                error?.configToast(isError: true)
            }
        }
    }
    
    func updateAddress() {
        if let address = self.address, let addressId = address.address_id {
            ServiceManager().processService(urlRequest: ComunicateService.Router.UpdateAddress(self.getParams(), addressId: addressId)) { (isSuccess, error , responseData) in
                if isSuccess {
                    print(responseData!)
                    "Your Address updated successfully.".configToast(isError: false)
                    self.navigationController?.popViewController(animated: true)
                    
                } else {
                    error?.configToast(isError: true)
                }
            }
        }
    }
    
    func getParams() -> [String: Any] {
        return [
            Constant.c_req_adddress_line1: self.line1TextField.text!,
            Constant.c_req_adddress_line2: self.line2TextField.text!,
            Constant.c_req_adddress_city: self.cityTextField.text!,
            Constant.c_req_adddress_state: self.stateTextField.text!,
            Constant.c_req_adddress_country: self.countryTextField.text!,
            Constant.c_req_adddress_zipcode: self.zipCodeTextField.text!
        ]
    }
    
    func showAlert() {
        "Please fill all field.".configToast(isError: false)
    }
}

extension AddUpdateAddressVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.zipCodeTextField {
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
