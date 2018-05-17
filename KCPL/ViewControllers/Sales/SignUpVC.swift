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
        
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
