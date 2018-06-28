//
//  OrderHistoryVC.swift
//  KCPL
//
//  Created by Aayushi Panchal on 04/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class OrderHistoryVC: AbstractVC {

    @IBOutlet weak var orderHistoryTableView: UITableView!
    
    var orderHistory : [Order]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderHistoryTableView.reloadData()
        self.orderHistoryTableView.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getOrderHistory()
    }

}

extension OrderHistoryVC {
    func getOrderHistory() {
        ServiceManager().processService(urlRequest: ComunicateService.Router.GetOrderHistory()) { (isSuccess, error , responseData) in
            if isSuccess {
                ServiceManagerModel().processOrderList(json: responseData, completion: { (isComplete, order) in
                    if isComplete {
                        self.orderHistory = order!
                        self.orderHistoryTableView.reloadData()
                    }
                    else {
                        
                    }
                })
            } else {
                error?.configToast(isError: true)
            }
        }
    }
}

//MARK:- SideMenu
extension OrderHistoryVC: SlideNavigationControllerDelegate {
    
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool
    {
        return true
    }
}

extension OrderHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let orders = self.orderHistory {
            return orders.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderHistoryCell") as! OrderHistoryTableViewCell
        
        if indexPath.row == 0 {
            cell.confirmButton.layer.borderColor = UIColor.init(red: 11.0/255.0, green: 92.0/255.0, blue: 174.0/255.0, alpha: 1.0).cgColor
            cell.confirmButton.setTitleColor(UIColor.init(red: 11.0/255.0, green: 92.0/255.0, blue: 174.0/255.0, alpha: 1.0), for: .normal)
        }
        else if indexPath.row == 1 {
            cell.confirmButton.layer.borderColor = UIColor.init(red: 243.0/255.0, green: 180.0/255.0, blue: 170.0/255.0, alpha: 1.0).cgColor
            cell.confirmButton.setTitleColor(UIColor.init(red: 243.0/255.0, green: 180.0/255.0, blue: 170.0/255.0, alpha: 1.0), for: .normal)
        }
        else {
            cell.confirmButton.layer.borderColor = UIColor.init(red: 0/255.0, green: 255.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
            cell.confirmButton.setTitleColor(UIColor.init(red: 0/255.0, green: 255.0/255.0, blue: 0.0/255.0, alpha: 1.0), for: .normal)
        }
        cell.confirmButton.layer.borderWidth = 1.0

        let order = self.orderHistory?[indexPath.row]
        cell.orderIdLabel.text = "Order# \(String(describing: order?.orderId!))"
//        if let date = order?.createdAt {
//            cell.processingLabel.text = "Processing:\(self.convertProcessingDate(date: date))"
//            
//        }
//        if let date = order?.confirmationDate {
//            cell.submittedDateLabel.text = self.convertProcessingDate(date: date)
//        }
        cell.shippingToLabel.text = order?.shipToAddress ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func convertProcessingDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss.fffz"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        return  dateFormatter.string(from: date!)
    }
}
