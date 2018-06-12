//
//  AdminDashboardVC.swift
//  KCPLAdmin
//
//  Created by Piyush Sanepara on 22/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminDashboardVC: UIViewController {

    @IBOutlet weak var dashboardCollectionView: UICollectionView!
    
    var arr = ["Sales", "Purchase", "Quotations", "Inventory", "Customers", "Vendors"]
    var arrImages = ["dash_sales", "dash_purchase", "dash_quotation", "dash_inventory", "dash_customers", "dash_vendors"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.configNavigationBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        dashboardCollectionView.collectionViewLayout.invalidateLayout()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.title = "Dashboard"
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        self.title = " "
//    }
    
    func configNavigationBar() {
        
        let logoimgView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        logoimgView.contentMode = .scaleAspectFit
        
        let logoBarButton = UIBarButtonItem(customView: logoimgView)
        self.navigationItem.leftBarButtonItem = logoBarButton
        
        let navNotification = UIBarButtonItem(image: #imageLiteral(resourceName: "nav_notification"), style: .plain, target: self, action:
            #selector(self.navNotificationPressed))
        
        let navLogout = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_signOut"), style: .plain, target: self, action:
            #selector(self.navSignoutPressed))
        
        self.navigationItem.rightBarButtonItems = [navLogout, navNotification]
        
    }
    
//    MARK:- Actions
    
    @objc func navNotificationPressed() {
        
    }
    
    @objc func navSignoutPressed() {
        AppRouter.sharedRouter().showAdminLogInScreen()
    }
   
}

extension AdminDashboardVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dashboardCollectionView.dequeueReusableCell(withReuseIdentifier: "AdminDashboardCollectionViewCell", for: indexPath) as! AdminDashboardCollectionViewCell
        
        cell.dashboardItemName.text = self.arr[indexPath.row]
        cell.dashboardItemImageView.image = UIImage(named: self.arrImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var w = CGFloat()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) { //if iPad is in landscape
                w = (collectionView.bounds.width/5.0) - 2.0
            } else { //if iPad is in portrait
                w = (collectionView.bounds.width/4.0) - 2.0
            }
        } else {
            if UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) { //if iPhone is in landscape
                w = (collectionView.bounds.width/3.0) - 2.0
            } else { //if iPhone is in portrait
                w = (collectionView.bounds.width/2.0) - 1.0 - 4
                
            }
        }
        
        let h = (collectionView.bounds.height / 3) - 2 - 4
        
        
        return CGSize(width: w, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0,0,0,0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            self.performSegue(withIdentifier: "showSalesFromDashboard", sender: nil)
        } else if indexPath.item == 1 {
            self.performSegue(withIdentifier: "showPurchaseFromDashboard", sender: nil)
        } else if indexPath.item == 2 {
            self.performSegue(withIdentifier: "showAdminQuatationFromAdminDashboard", sender: nil)
        } else if indexPath.item == 3 {
            self.performSegue(withIdentifier: "showAdminInventoryFromDashboard", sender: nil)
        } else if indexPath.item == 4 {
            self.performSegue(withIdentifier: "showAdminCustomerFromAdminDashboard", sender: nil)
        } else if indexPath.item == 5 {
            self.performSegue(withIdentifier: "showVendorFromDashboard", sender: nil)
        }
    }
    
}
