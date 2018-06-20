//
//  DashboardVC.swift
//  KCPL
//
//  Created by Aayushi Panchal on 03/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit
import SDWebImage

class DashboardVC: AbstractVC {
    
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    var categoriesDatasource = [Category]()
    var filterCategories = [Category]()

    var navCart = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        self.configNavigationBar()
        self.getCategoryList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateBadge()
    }
    
    func updateBadge() {
        if let cartArray_temp = UserDefault.getCartProducts(), cartArray_temp.count > 0 {
            navCart.addBadge(number: cartArray_temp.count)
        } else {
            navCart.removeBadge()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.itemsCollectionView.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        itemsCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func configNavigationBar() {
        navCart = UIBarButtonItem(image: UIImage(named: "nav_cart"), style: .plain, target: self, action: #selector(DashboardVC.navCartPressed))
        
        let navCall = UIBarButtonItem(image: UIImage(named: "nav_call"), style: .plain, target: self, action:
            #selector(DashboardVC.navCallPressed))
        
        let navNotification = UIBarButtonItem(image: UIImage(named: "nav_notification"), style: .plain, target: self, action:
            #selector(DashboardVC.navNotificationPressed))
//
        self.navigationItem.rightBarButtonItems  = [navCart, navCall, navNotification]
    }
    
    //    MARK:- Actions
    
    @objc func navCartPressed() {
        self.performSegue(withIdentifier: "showCartFromDashboard", sender: nil)
    }
    
    @objc func navCallPressed() {
        
    }
    
    @objc func navNotificationPressed() {
        self.performSegue(withIdentifier: "showNotificationFromDashboard", sender: nil)
    }
    
    //    MARK:- Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProductListFromDashboard" {
            if let toVC = segue.destination as? ProductListVC, let indexPath = sender as? IndexPath {
                toVC.category = filterCategories[indexPath.row]
                toVC.categoryId = filterCategories[indexPath.row].id
            }
        }
    }
}

extension DashboardVC {
    func getCategoryList() {
        ServiceManager().processService(urlRequest: ComunicateService.Router.GetCategories()) { (isSuccess, error , responseData) in
            if isSuccess {
                ServiceManagerModel().processCategories(json: responseData, completion: { (isComplete, categories) in
                    if isComplete {
                        self.categoriesDatasource = categories!
                        self.filterCategories = self.categoriesDatasource
                        self.itemsCollectionView.delegate = self
                        self.itemsCollectionView.dataSource = self
                        
                        self.itemsCollectionView.reloadData()
                    } else {
                        
                    }
                })
            } else {
                error?.configToast(isError: true)
            }
        }
    }
}

extension DashboardVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterCategories.removeAll()
        if searchText.count > 0 {
            self.filterCategories = self.categoriesDatasource.filter({($0.name?.lowercased().contains(searchText.lowercased()))!})
            self.itemsCollectionView.reloadData()
        }
        else {
            self.filterCategories = self.categoriesDatasource
            self.itemsCollectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension DashboardVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.itemsCollectionView.isHidden = !(filterCategories.count > 0)
        return self.filterCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.itemsCollectionView.dequeueReusableCell(withReuseIdentifier: "DashboardItemCell", for: indexPath) as! DashboardItemCell
        
        cell.itemNameLabel.text = self.filterCategories[indexPath.row].name
        cell.itemImageView.sd_setImage(with: URL.init(string: self.filterCategories[indexPath.row].image!), placeholderImage: UIImage.init(named: "item_detail"), options: .fromCacheOnly, completed: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var w = CGFloat()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) { //if iPad is in landscape
                w = (itemsCollectionView.bounds.width/5.0) - 2.0
            } else { //if iPad is in portrait
                w = (itemsCollectionView.bounds.width/4.0) - 2.0
            }
        } else {
            if UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) { //if iPhone is in landscape
                w = (itemsCollectionView.bounds.width/3.0) - 2.0
            } else { //if iPhone is in portrait
                w = (itemsCollectionView.bounds.width/2.0) - 8.0
                
            }
        }
        
        let h = w + (self.filterCategories[indexPath.row].name?.height(withConstrainedWidth: w, font: ConstantsUI.C_Font_LableTitle))!
        
        return CGSize(width: w, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0,0,0,0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showProductListFromDashboard", sender: indexPath)        
    }
}

//MARK:- SideMenu
extension DashboardVC: SlideNavigationControllerDelegate {
    
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool
    {
        return true
    }
}
