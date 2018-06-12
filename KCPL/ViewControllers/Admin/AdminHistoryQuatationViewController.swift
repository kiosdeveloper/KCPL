//
//  AdminHistoryQuatationViewController.swift
//  KCPL
//
//  Created by Piyush Sanepara on 08/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminHistoryQuatationViewController: UIViewController {

    @IBOutlet var historyQuatationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        historyQuatationTableView.register(UINib.init(nibName: "HistoryQuatationCell", bundle: nil), forCellReuseIdentifier: "HistoryQuatationCell")
    }
}

extension AdminHistoryQuatationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = historyQuatationTableView.dequeueReusableCell(withIdentifier: "HistoryQuatationCell") as! HistoryQuatationCell
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showAdminQuatationDetailFromAdminHistoryQuatation", sender: self)
    }
}
