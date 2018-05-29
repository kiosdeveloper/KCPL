//
//  SignUpVC.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 03/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var companyAddressTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var gstInNumberTextField: UITextField!
    @IBOutlet weak var deliveryAddressTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    @IBOutlet weak var navigationViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configLoginButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func configLoginButton() {
        let loginText = "Already have an account? Log-in" as NSString
        let loginAttributedString = NSMutableAttributedString(string: loginText as String, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor:ConstantsUI.C_Color_darkGray])
        loginAttributedString.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor:ConstantsUI.C_Color_Theme], range: loginText.range(of: "Log-in"))
        
        self.loginButton.setAttributedTitle(loginAttributedString, for: .normal)
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        if self.isValidUser() {
            self.signUpUser()
        }
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SignUpVC{
    func isValidUser() -> Bool {
        if self.firstNameTextField.text == "" {
            Constant.c_error_firstname.configToast(isError: true)
            return false
        }
        
        else if self.lastNameTextField.text == "" {
            Constant.c_error_lastname.configToast(isError: true)
            return false
        }
            
        else if self.companyNameTextField.text == "" {
            Constant.c_error_companyname.configToast(isError: true)
            return false
        }
            
        else if self.companyAddressTextField.text == "" {
            Constant.c_error_company_address.configToast(isError: true)
            return false
        }
        
        else if self.mobileNumberTextField.text == "" {
            Constant.c_error_mobile.configToast(isError: true)
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
        
        else if self.passwordTextField.text == "" {
            Constant.c_error_password.configToast(isError: true)
            return false
        }
            
        else if self.confirmPasswordTextField.text == "" {
            Constant.c_error_confirm_password.configToast(isError: true)
            return false
        }
        
        else if self.passwordTextField.text != self.confirmPasswordTextField.text {
            Constant.c_not_match_confirm_password.configToast(isError: true)
            return false
        }
        
        else if self.gstInNumberTextField.text == "" {
            Constant.c_error_gst_number.configToast(isError: true)
            return false
        }
        
        else if self.deliveryAddressTextField.text == "" {
            Constant.c_error_delivery_address.configToast(isError: true)
            return false
        }
        return true
    }
    
    func signUpUser() {
        let uuid = NSUUID().uuidString.lowercased()
        let deviceGUID = UIDevice.current.identifierForVendor!.uuidString + uuid
        
        let params: [String: Any] = [
            Constant.c_req_customer_email: self.emailTextField.text!,
            Constant.c_req_customer_password: self.passwordTextField.text!,
            
            Constant.c_req_first_name: self.firstNameTextField.text!,
            Constant.c_req_last_name: self.lastNameTextField.text!,
            Constant.c_req_confirm_password: self.confirmPasswordTextField.text!,
            Constant.c_req_device_token: deviceGUID,
            Constant.c_req_device_type: "1",
            Constant.c_req_address: self.companyAddressTextField.text!,
            Constant.c_req_phone: self.mobileNumberTextField.text!,
        ]
        
        ServiceManager().processService(urlRequest: ComunicateService.Router.SignUp(params)) { (isSuccess, error , responseData) in
            if isSuccess {
                //print(responseData)
                
                ServiceManagerModel().processLogin(json: responseData, completion: { (isComplete) in
                    if isComplete {
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            } else {
                error?.configToast(isError: true)
            }
        }
    }
}
