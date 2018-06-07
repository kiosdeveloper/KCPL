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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
