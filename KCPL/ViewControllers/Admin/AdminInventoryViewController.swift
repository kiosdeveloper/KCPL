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
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Inventory"
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
//    MARK:- Action
    @IBAction func ActionPressed(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Select Action", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Make Sales Order", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: "showAdminCartFromAdminInventory", sender: ScreenType.SalesScreen)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Make Purchase Order", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: "showAdminCartFromAdminInventory", sender: ScreenType.PurchaseScreen)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAdminCartFromAdminInventory" {
                
            if let toVC = segue.destination as? AdminCartViewController, let screenType = sender as? ScreenType {
                toVC.fromScreenType = screenType
            }
        }
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
