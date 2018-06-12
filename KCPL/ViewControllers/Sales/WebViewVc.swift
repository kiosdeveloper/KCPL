//
//  WebViewVc.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 02/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class WebViewVc: AbstractVC {

    @IBOutlet weak var webView: UIWebView!
    
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let textAttributes = [NSAttributedStringKey.foregroundColor:ConstantsUI.C_Color_Title]
//        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.webView.loadRequest(URLRequest(url: URL(string: url)!))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//MARK:- SideMenu
extension WebViewVc: SlideNavigationControllerDelegate {
    
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool
    {
        return true
    }
}
