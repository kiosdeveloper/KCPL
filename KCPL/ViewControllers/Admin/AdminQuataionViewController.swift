//
//  AdminQuataionViewController.swift
//  KCPL
//
//  Created by Piyush Sanepara on 08/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminQuataionViewController: UIViewController {
    let viewControllerIdentifiers = ["AdminPendingQuatationViewController", "AdminHistoryQuatationViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    MARK:- Actions
    
    @IBAction func quationSegmentValueChanged(_ sender: UISegmentedControl) {
//        https://stackoverflow.com/questions/28003602/swift-how-to-link-two-view-controllers-into-one-container-view-and-switch-betw?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
        
        let newController = UIStoryboard(name: "Admin", bundle: nil).instantiateViewController(withIdentifier: viewControllerIdentifiers[sender.selectedSegmentIndex])
        
        let oldController = childViewControllers.last!
        
        oldController.willMove(toParentViewController: nil)
        addChildViewController(newController)
        newController.view.frame = oldController.view.frame
        
        transition(from: oldController, to: newController, duration: 0.25, options: .transitionCrossDissolve, animations: {
            // nothing needed here
        }, completion: { _ -> Void in
            oldController.removeFromParentViewController()
            newController.didMove(toParentViewController: self)
        })
    }
    
}
