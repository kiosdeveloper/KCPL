//
//  AdminLoginViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 18/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    MARK:- Actions
    
    @IBAction func LoginPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showAdminDashboardFromAdminLogin", sender: nil)
    }
    
}
