//
//  AdminSalesViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 07/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminSalesViewController: UIViewController {

    @IBOutlet weak var salesTableView: UITableView!
    
    let cellIdentifier = "salesCell"
    
    var orderNumberArray = ["3259A", "3289B", "3250C"]
    var companyNameArray = ["Shanghai Global Spares", "Southwest Global Spares", "India Steel Spares"]
    var timeArray = ["2 Hr. Ago", "6 Hr. Ago", "2 Days Ago"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
}

extension AdminSalesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderNumberArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! AdminSalesTableViewCell
        cell.orderNumberLabel.text = "Sales Order- #" + self.orderNumberArray[indexPath.row]
        cell.companyNameLabel.text = self.companyNameArray[indexPath.row]
        cell.timeLabel.text = self.timeArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}