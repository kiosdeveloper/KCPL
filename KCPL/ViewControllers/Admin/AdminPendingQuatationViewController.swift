//
//  AdminPendingQuatationViewController.swift
//  KCPL
//
//  Created by Piyush Sanepara on 08/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminPendingQuatationViewController: UIViewController {

    @IBOutlet var pendingQuatationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        pendingQuatationTableView.register(UINib.init(nibName: "PendingQuatationCell", bundle: nil), forCellReuseIdentifier: "PendingQuatationCell")
        
    }
}

extension AdminPendingQuatationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in  : UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = pendingQuatationTableView.dequeueReusableCell(withIdentifier: "PendingQuatationCell") as! PendingQuatationCell
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showAdminQuatationDetailFromAdminPendingQuatation", sender: self)
    }
}
