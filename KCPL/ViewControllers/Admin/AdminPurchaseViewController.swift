//
//  AdminPurchaseViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 07/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminPurchaseViewController: UIViewController {
    
    @IBOutlet weak var purchaseTableView: UITableView!
    
    let cellIdentifier = "purchaseCell"
    
    var orderNumberArray = ["3259A", "3289B", "3250C"]
    var companyNameArray = ["Hill Top Technologies", "Karnavati Corp. Pvt. Ltd.", "Majumdar Spares"]
    var timeArray = ["2 Hr. Ago", "3 Hr. Ago", "6 Hr. Ago"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension AdminPurchaseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! AdminPurchaseTableViewCell
        cell.orderNumberLabel.text = "Purchase Order- #" + self.orderNumberArray[indexPath.row]
        cell.companyNameLabel.text = self.companyNameArray[indexPath.row]
        cell.timeLabel.text = self.timeArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
