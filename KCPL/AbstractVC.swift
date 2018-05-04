//
//  AbstractVC.swift
//  demoApp
//
//  Created by Aayushi Panchal on 22/09/17.
//  Copyright © 2017 Aayushi Panchal. All rights reserved.
//

import UIKit

protocol Controller {
    var view: View? { get set }
}

protocol View {
    var controller: Controller? { get set }
}

class AbstractVC: UIViewController, View  {
    
    var controller: Controller?
//    var screenType: AppScreenType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//    func dismissIndicator() {
//        DispatchQueue.main.async {
//            FTProgressIndicator.dismiss()
//        }
//    }
    
//    func configToast(message: String) {
//        
//        self.navigationController?.view.makeToast(message)
//        
//    }//End configToast()
    func hideBackButton() {
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    func hideNavigationBar() {
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    func showNavigationBar() {
        
        if let navController = self.navigationController {
            navController.setNavigationBarHidden(false, animated: true)
        }
    }
}
