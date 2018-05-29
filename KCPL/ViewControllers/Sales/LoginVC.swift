//
//  LoginVC.swift
//  KCPL
//
//  Created by Aayushi Panchal on 02/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var usernameTextFeild: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var navigationViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Util.isSalesApp() {
            self.signUpButton.isHidden = true
        } else {
            self.configSignUpButton() 
        }
        
    }
    
    func configSignUpButton() {
        let signUpText = "Don't have account? SIGN UP" as NSString
        let signUpAttributedString = NSMutableAttributedString(string: signUpText as String, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor:ConstantsUI.C_Color_darkGray])
        signUpAttributedString.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor:ConstantsUI.C_Color_Theme], range: signUpText.range(of: "SIGN UP"))
        
        self.signUpButton.setAttributedTitle(signUpAttributedString, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
        
        if usernameTextFeild.text == "" {
            Constant.c_error_email.configToast(isError: true)
            return false
        }
        
        if !(usernameTextFeild.text!.isValidEmail()) {
            Constant.c_error_valid_email.configToast(isError: true)
            return false
        }
        
        if passwordTextFeild.text == "" {
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

//MARK:- Helper Method
extension LoginVC {
    func Login() {
        let params: [String: Any] = [
            Constant.c_req_customer_email: usernameTextFeild.text!,
            Constant.c_req_customer_password: passwordTextFeild.text!
        ]
        
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
