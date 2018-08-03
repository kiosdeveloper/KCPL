//
//  LoginVC.swift
//  KCPL
//
//  Created by Aayushi Panchal on 02/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var navigationViewHeight: NSLayoutConstraint!
    
    let textFieldDelegate = CommonTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Util.isSalesApp() {
            self.signUpButton.isHidden = true
            self.usernameTextField.text = "admin@godfather.com"
            self.passwordTextField.text = "password"
        } else {
            self.configSignUpButton() 
        }
        
        self.usernameTextField.delegate = textFieldDelegate
        self.passwordTextField.delegate = textFieldDelegate
    }
    
    func configSignUpButton() {
        let signUpText = "Don't have account? SIGN UP" as NSString
        let signUpAttributedString = NSMutableAttributedString(string: signUpText as String, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor:ConstantsUI.C_Color_darkGray])
        signUpAttributedString.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor:ConstantsUI.C_Color_Theme], range: signUpText.range(of: "SIGN UP"))
        
        self.signUpButton.setAttributedTitle(signUpAttributedString, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        if let user = UserDefault.getUser(), let _ = user.auth_token, let _ = user.id {
            self.performSegue(withIdentifier: "showDashboardFromLogin", sender: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
//    MARK:- Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func salesLoginClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
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
    @IBAction func loginPressed(_ sender: Any) {
        if self.isValidateLogin() {
            self.Login()
        }
    }
}

//extension LoginVC: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard range.location == 0 else {
//            return true
//        }
//        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
//        return newString.rangeOfCharacter(from: NSCharacterSet.whitespacesAndNewlines).location != 0
//    }
//}

//MARK:- Helper Method
extension LoginVC {
    func Login() {
        
        var params: [String: Any] = [:]
        if !Util.isSalesApp() {
            params = [Constant.c_req_customer_email: usernameTextField.text!,
                      Constant.c_req_customer_password: passwordTextField.text!]
        }
        else {
            let uuid = NSUUID().uuidString.lowercased()
            let deviceGUID = UIDevice.current.identifierForVendor!.uuidString + uuid
            
            params = [Constant.c_req_customer_email: usernameTextField.text!,
                      Constant.c_req_customer_password: passwordTextField.text!,
                      Constant.c_req_device_token: deviceGUID,
                      Constant.c_req_device_type: "1"]
        }
        
        ServiceManager().processService(urlRequest: ComunicateService.Router.Login(params)) { (isSuccess, error , responseData) in
            if isSuccess {
                //print(responseData)
                
                ServiceManagerModel().processLogin(json: responseData, completion: { (isComplete) in
                    if isComplete {
                        self.performSegue(withIdentifier: "showDashboardFromLogin", sender: nil)
                    }
                })
            } else {
                error?.configToast(isError: true)
            }
        }
    }
}
