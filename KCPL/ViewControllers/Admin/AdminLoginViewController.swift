//
//  AdminLoginViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 18/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminLoginViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configSignUpButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configSignUpButton() {
        let signUpText = "Don't have account? SIGN UP" as NSString
        let signUpAttributedString = NSMutableAttributedString(string: signUpText as String, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor:ConstantsUI.C_Color_darkGray])
        signUpAttributedString.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor:ConstantsUI.C_Color_Theme], range: signUpText.range(of: "SIGN UP"))
        
        self.signUpButton.setAttributedTitle(signUpAttributedString, for: .normal)
    }
    
//    MARK:- Actions
    
    @IBAction func LoginPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showAdminDashboardFromAdminLogin", sender: nil)
    }
    
}
