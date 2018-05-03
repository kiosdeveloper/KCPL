//
//  SignUpViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 03/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginText = "Already Have an account Log-in" as NSString
        let loginAttributedString = NSMutableAttributedString(string: loginText as String, attributes: [NSAttributedStringKey.font:UIFont(name: "Helvetica Neue", size: CGFloat(17))!, NSAttributedStringKey.foregroundColor:UIColor.darkGray])
        loginAttributedString.addAttributes([NSAttributedStringKey.font: UIFont(name: "Helvetica Neue", size: CGFloat(17))!, NSAttributedStringKey.foregroundColor:UIColor(red: 11.0/255.0, green: 92.0/255.0, blue: 174.0/255.0, alpha: 1.0)], range: appliedJobsText.range(of: "Log-in"))
        
        self.loginButton.setAttributedTitle(loginAttributedString, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
    }
}
