//
//  OrderHistoryDetailVC.swift
//  KCPL
//
//  Created by MacBook Pro on 29/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class OrderHistoryDetailVC: UIViewController {
    
    @IBOutlet var orderHistoryDetailTableview: UITableView!
    
    var orderDetail: Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.orderHistoryDetailTableview.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        
        orderHistoryDetailTableview.register(UINib.init(nibName: "CartTotalCell", bundle: nil), forCellReuseIdentifier: "CartTotalCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "My Order Detail"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
}

extension OrderHistoryDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 8
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHistoryDetailHeaderCell") as! OrderHistoryDetailHeaderCell
            
            return cell
            
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartTotalCell") as! CartTotalCell
            
            return cell
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHistoryDetailItemCell") as! OrderHistoryDetailItemCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 150
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
}
