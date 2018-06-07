//
//  AdminVendorViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 07/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminVendorViewController: UIViewController {
    
    @IBOutlet weak var vendorTableView: UITableView!
    
    let cellIdentifier = "vendorCell"
    
    var contactNumberArray = ["9867122355", "8972376232", "8986123222", "8712638112", "8726378622"]
    var companyNameArray = ["Shanghai Global Spares", "Southwest Global Spares", "India Steel Spares", "Shanghai Global Spares", "Southwest Global Spares"]
    var gradeArray = ["A", "B", "C", "B", "A"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension AdminVendorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.companyNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! AdminVendorTableViewCell
        cell.contactNumberLabel.text = self.contactNumberArray[indexPath.row]
        cell.companyNameLabel.text = self.companyNameArray[indexPath.row]
        cell.gradeLabel.text = self.gradeArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
