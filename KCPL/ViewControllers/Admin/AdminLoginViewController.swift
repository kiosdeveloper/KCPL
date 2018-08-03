//
//  AdminLoginViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 18/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminLoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let textFieldDelegate = CommonTextFieldDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTextField.text = "admin@godfather.com"
        self.passwordTextField.text = "password"
        
        self.usernameTextField.delegate = textFieldDelegate
        self.passwordTextField.delegate = textFieldDelegate
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        if let user = UserDefault.getUser(), let _ = user.auth_token, let _ = user.id {
            self.performSegue(withIdentifier: "showAdminDashboardFromAdminLogin", sender: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
//    MARK:- Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func isValidateLogin() -> Bool {
        
        if usernameTextField.text == "" {
            Constant.c_error_email.configToast(isError: true)
            return false
        }
        
        if !(usernameTextField.text!.isValidEmail()) {
            Constant.c_error_valid_email.configToast(isError: true)
            return false
        }
        
        if passwordTextField.text == "" {
            Constant.c_error_password.configToast(isError: true)
            return false
        }
        
        return true
    }
    
//    MARK:- Actions
    
    @IBAction func LoginPressed(_ sender: Any) {
        if self.isValidateLogin() {
            self.Login()
        }
    }
    
}

//MARK:- Helper Method
extension AdminLoginViewController {
    func Login() {
        
        let uuid = NSUUID().uuidString.lowercased()
        let deviceGUID = UIDevice.current.identifierForVendor!.uuidString + uuid
        
        let params = [Constant.c_req_customer_email: usernameTextField.text!,
                  Constant.c_req_customer_password: passwordTextField.text!,
                  Constant.c_req_device_token: deviceGUID,
                  Constant.c_req_device_type: "1"]
        
        ServiceManager().processService(urlRequest: ComunicateService.Router.Login(params)) { (isSuccess, error , responseData) in
            if isSuccess {
                //print(responseData)
                
                ServiceManagerModel().processLogin(json: responseData, completion: { (isComplete) in
                    if isComplete {
                        self.performSegue(withIdentifier: "showAdminDashboardFromAdminLogin", sender: nil)
                    }
                })
            } else {
                error?.configToast(isError: true)
            }
        }
    }
}
