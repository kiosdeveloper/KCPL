//
//  AdminInventoryViewController.swift
//  KCPL
//
//  Created by Piyush Sanepara on 07/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminInventoryViewController: AbstractVC {
    
    @IBOutlet var inventoryTableview: UITableView!
    
    @IBOutlet var headerView: ThemeShadowView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerView.layer.borderColor = ConstantsUI.C_Color_Theme.cgColor
        self.headerView.layer.borderWidth = 1.0
        
        inventoryTableview.register(UINib.init(nibName: "InventoryTableViewCell", bundle: nil), forCellReuseIdentifier: "InventoryTableViewCell")
    }
}

extension AdminInventoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = inventoryTableview.dequeueReusableCell(withIdentifier: "InventoryTableViewCell") as! InventoryTableViewCell
        
        
        return cell
    }
    
}
