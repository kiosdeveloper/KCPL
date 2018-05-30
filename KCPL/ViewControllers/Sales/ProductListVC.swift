//
//  ProductListVC.swift
//  KCPL
//
//  Created by Piyush Sanepara on 29/05/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class ProductListVC: AbstractVC {

    @IBOutlet weak var productlistTableView: ThemeTableView!
    
    var productsDatasource = [Product]()
    
    var category: Category?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getProductList()
    }
}

extension ProductListVC {
    func getProductList() {
        ServiceManager().processService(urlRequest: ComunicateService.Router.GetProductList()) { (isSuccess, error , responseData) in
            if isSuccess {
                ServiceManagerModel().processProducts(json: responseData, completion: { (isComplete, products) in
                    
                    if isComplete {
                        self.productsDatasource = products!
                        
                        self.productlistTableView.delegate = self
                        self.productlistTableView.dataSource = self
                        
                        self.productlistTableView.reloadData()
                    } else {
                        
                    }
                })
                
                
            } else {
                error?.configToast(isError: true)
            }
        }
        
    }
}

extension ProductListVC: SlideNavigationControllerDelegate {
    
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool
    {
        return true
    }
}

extension ProductListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = productlistTableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell") as! ProductListTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showItemDetailFromProductList", sender: indexPath)
    }
}
