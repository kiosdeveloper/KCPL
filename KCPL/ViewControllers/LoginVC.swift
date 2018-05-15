//
//  LoginVC.swift
//  KCPL
//
//  Created by Aayushi Panchal on 02/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var navigationViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        #if SALES
            print("Sales")
        #else
            print("Customer")
        #endif

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
    
//    MARK:- Actions
    @IBAction func loginPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "showDashboardFromLogin", sender: nil)
    }
}
