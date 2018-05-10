//
//  DeliveryAddressVC.swift
//  KCPL
//
//  Created by Aayushi Panchal on 10/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class DeliveryAddressVC: AbstractVC {
    
    @IBOutlet weak var deliveryAddressTableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension DeliveryAddressVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = deliveryAddressTableView.dequeueReusableCell(withIdentifier: "CartItemListCell") as! CartItemListCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        return titleLabel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
