//
//  DashboardVC.swift
//  KCPL
//
//  Created by Aayushi Panchal on 03/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {

    @IBOutlet weak var itemsCollectionView: UICollectionView!
    var arr = ["Suspention & Brakes Suspention & Brakes", "Lamps", "Suspention & Brakes", "Lamps & Suspention & Brakes & Combo etc...", "Suspention & Brakes", "Lamps", "Suspention & Brakes", "Lamps"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        itemsCollectionView.collectionViewLayout.invalidateLayout()
    }

}

extension DashboardVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.itemsCollectionView.isHidden = !(arr.count > 0)
        return self.arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.itemsCollectionView.dequeueReusableCell(withReuseIdentifier: "DashboardItemCell", for: indexPath) as! DashboardItemCell
        
        cell.itemNameLabel.text = self.arr[indexPath.row]
        
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
                w = (itemsCollectionView.bounds.width/2.0) - 1.0
                
            }
        }
        
        let h = w + self.arr[indexPath.row].height(withConstrainedWidth: w, font: ConstantsUI.C_Font_LableTitle)
        
        return CGSize(width: w, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0,0,0,0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ItemDetailViewController") as! ItemDetailViewController
        self.navigationController?.pushViewController(itemDetailViewController, animated: true)
    }
    
    func estimatedHeightOfLabel(text: String) -> CGFloat {
        
        let size = CGSize(width: view.frame.width - 16, height: 1000)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let attributes = [kCTFontAttributeName: UIFont.systemFont(ofSize: 17)]
        
        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes as [NSAttributedStringKey : Any], context: nil).height
        
        return rectangleHeight
    }
}
