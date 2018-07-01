//
//  OrderHistoryDetailVC.swift
//  KCPL
//
//  Created by MacBook Pro on 29/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit
import SDWebImage

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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return (self.orderDetail?.products.count)!
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHistoryDetailHeaderCell") as! OrderHistoryDetailHeaderCell
            cell.orderIdLabel.text = "Order #" + String(self.orderDetail?.orderId ?? 123)
            
            if let date = self.orderDetail?.confirmationDate {
                cell.submittedDateLabel.text = self.convertProcessingDate(date: date)
            }
            else {
                cell.submittedDateLabel.text = self.convertProcessingDate(date: (self.orderDetail?.createdAt)!)
            }
            cell.totalAmountLabel.text = "₹ " + self.calculateTotalAmount()
            switch self.orderDetail?.status {
            case 0:
                cell.orderStatusLabel.text = "Pending"
            case 1:
                cell.orderStatusLabel.text = "Processing"
            case 2:
                cell.orderStatusLabel.text = "Complete"
            default:
                cell.orderStatusLabel.text = "Delivered"
            }
            
            cell.shippingAddressLabel.text = self.orderDetail?.shipToAddress ?? ""
            cell.billingAddressLabel.text = self.orderDetail?.billToAddress ?? ""
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHistoryDetailItemCell") as! OrderHistoryDetailItemCell
            let product = self.orderDetail?.products[indexPath.row]
            cell.productImageView.sd_setImage(with: URL(string: product?.image_url ?? ""), placeholderImage: #imageLiteral(resourceName: "logo"), completed: nil)
            cell.productNameLabel.text = product?.name ?? ""
            cell.productPriceLabel.text = "₹ \(product?.price ?? 0)"
            cell.productQtyLabel.text = "Qty. \(product?.qty ?? 0)"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartTotalCell") as! CartTotalCell
            
            cell.subTotalLable.text = "₹ " + self.countSubTotal()
            cell.shippingLable.text = "₹ 0"
            cell.gstLabel.text = "₹ " + self.countTax()
            cell.totalLabel.text = "₹ " + self.calculateTotalAmount()

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func countSubTotal() -> String {
        var total = 0
        for product in (self.orderDetail?.products)! {
            total = ((product.price ?? 0) * (product.qty ?? 0)) + total
        }
        return String(total)
    }
    
    func countTax() -> String {
        var tax = 0.0
        for product in (self.orderDetail?.products)! {
            tax = product.tax ?? 0.0 + tax
        }
        return String(tax)
    }
    
    func calculateTotalAmount() -> String {
        var productPrice = 0.0
        for product in (self.orderDetail?.products)! {
            productPrice = Double(product.price! * product.qty!) + product.tax! + productPrice
        }
        return String(productPrice)
    }
    
    func convertProcessingDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date!)
    }
}
