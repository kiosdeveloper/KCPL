//
//  ProfileVC.swift
//  KCPL
//
//  Created by Piyush Sanepara on 22/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class ProfileVC: AbstractVC {
    
    @IBOutlet var firstNameTextField: UITextField!
    
    @IBOutlet var lastNameTextField: UITextField!
    
    @IBOutlet var companyNameTextField: UITextField!
    
    @IBOutlet var addressTextField: UITextField!
    
    @IBOutlet var mobileNoTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    var navCart = UIBarButtonItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.configNavigationBar()
        self.setUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Profile"
//        self.updateBadge()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    func setUserData() {
        if let user = UserDefault.getUser() {
            self.firstNameTextField.text = user.first_name
            self.lastNameTextField.text = user.last_name
            self.addressTextField.text = user.address
            self.mobileNoTextField.text = user.phone
            self.emailTextField.text = user.email
        }
    }
    
    func updateBadge() {
        if let cartArray_temp = UserDefault.getCartProducts(), cartArray_temp.count > 0 {
            navCart.addBadge(number: cartArray_temp.count)
        } else {
            navCart.removeBadge()
        }
    }
    
    func configNavigationBar() {
        
        navCart = UIBarButtonItem(image: UIImage(named: "nav_cart"), style: .plain, target: self, action: #selector(DashboardVC.navCartPressed))
        
        let navCall = UIBarButtonItem(image: UIImage(named: "nav_call"), style: .plain, target: self, action:
            #selector(DashboardVC.navCallPressed))
        
        let navNotification = UIBarButtonItem(image: UIImage(named: "nav_notification"), style: .plain, target: self, action:
            #selector(DashboardVC.navNotificationPressed))
        //
        self.navigationItem.rightBarButtonItems  = [navCart, navCall, navNotification]
    }
    
//    MARK:- Actions
    
    @IBAction func updateProfilePressed(_ sender: Any) {
        if self.isValidUser() {
            self.updateUser()
        }
    }
}

extension ProfileVC {
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
            
        else if self.addressTextField.text == "" {
            Constant.c_error_company_address.configToast(isError: true)
            return false
        }
            
        else if self.mobileNoTextField.text == "" {
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
        
        return true
    }
    
    func updateUser() {
        
        var params: [String: Any] = [
            Constant.c_req_customer_email: self.emailTextField.text!,
            Constant.c_req_first_name: self.firstNameTextField.text!,
            Constant.c_req_last_name: self.lastNameTextField.text!,
            Constant.c_req_address: self.addressTextField.text!,
            Constant.c_req_phone: self.mobileNoTextField.text!
            ]
        
        if self.passwordTextField.text != "" {
            params[Constant.c_req_customer_password] = self.passwordTextField.text!
        }
        
        print(params)
        
        ServiceManager().processService(urlRequest: ComunicateService.Router.UpdateUser(params)) { (isSuccess, error , responseData) in
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

//MARK:- SideMenu
extension ProfileVC: SlideNavigationControllerDelegate {
    
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool
    {
        return true
    }
}
