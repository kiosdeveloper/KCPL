//
//  AppRouter.swift
//  KCPL
//
//  Created by Aayushi Panchal on 04/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit
import Foundation

let _sharedRouter: AppRouter = { AppRouter() }()

class AppRouter: NSObject, Controller {
    
    var appWindow : UIWindow?
    var container: UIViewController?
    var subContainerInTabbar: UINavigationController?
    var view: View?
    
    // Singleton class
    class func sharedRouter() -> AppRouter {
        return _sharedRouter
    }
    
    func getViewController(_ screenName: String) -> AbstractVC {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: screenName) as! AbstractVC
        return viewController
    }
    
    func getNavigationController() -> UINavigationController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyBoard.instantiateViewController(withIdentifier: "SlideNavigationController") as! UINavigationController
        return navigationController
    }
    
    func getAdminNavigationController() -> UINavigationController {
        let storyBoard = UIStoryboard(name: "Admin", bundle: nil)
        let navigationController = storyBoard.instantiateViewController(withIdentifier: "navController") as! navController
        return navigationController
    }
    
    func showAdminLogInScreen() {
        let loginVC = UIStoryboard(name: "Admin", bundle: nil).instantiateViewController(withIdentifier: "AdminLoginViewController") as! AdminLoginViewController
        
        let appDelegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        appDelegate.window?.rootViewController = loginVC
    }
//
//    func showTaskScreen() {
//        let taskVC = self.getViewController("TaskVC") as? TaskVC
//        taskVC!.controller = self
//        view = taskVC
//
//        let navigationController: UINavigationController = getNavigationController()
//        navigationController.viewControllers = [taskVC!]
//        container = taskVC
//
//        let appDelegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
//        appDelegate.window?.rootViewController = navigationController
//    }
    
    func configSlideNavigation() {
    
        if !Util.isAdminApp() {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let leftMenu = mainStoryboard.instantiateViewController(withIdentifier: "leftMenuViewController") as! leftMenuViewController
            
            SlideNavigationController.sharedInstance().leftMenu = leftMenu
        }
    }    
}

