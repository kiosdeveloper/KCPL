//
//  AdminPendingQuatationViewController.swift
//  KCPL
//
//  Created by Piyush Sanepara on 08/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminPendingQuatationViewController: UIViewController, AdminQuatationDetailViewControllerDelegate {
    
    var pendingQuatationDatasource = [Quatations]()

    @IBOutlet var pendingQuatationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        pendingQuatationTableView.register(UINib.init(nibName: "PendingQuatationCell", bundle: nil), forCellReuseIdentifier: "PendingQuatationCell")
        self.getPendingQuatation()
    }
    
//    Delegate Method for reload
    func needToReload() {
        self.getPendingQuatation()
    }
    
//    MARK:- Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAdminQuatationDetailFromAdminPendingQuatation" {
            if let toVC = segue.destination as? AdminQuatationDetailViewController, let indexPath = sender as? IndexPath  {
                toVC.delegate = self
                toVC.quatation = self.pendingQuatationDatasource[indexPath.row]
                toVC.fromScreenType = ScreenType.AdminPendingQuatationScreen
            }
        }
    }
}

extension AdminPendingQuatationViewController: UITableViewDelegate, UITableViewDataSource, PendingQuatationDelegate {
    
    func numberOfSections(in  : UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.pendingQuatationDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = pendingQuatationTableView.dequeueReusableCell(withIdentifier: "PendingQuatationCell") as! PendingQuatationCell
        
        cell.delegate = self
        
        cell.setDataSource(quatation: self.pendingQuatationDatasource[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showAdminQuatationDetailFromAdminPendingQuatation", sender: indexPath)
    }
    
    func acceptButton(cell: PendingQuatationCell) {
        guard let indexPath = self.pendingQuatationTableView.indexPath(for: cell) else { return }
        
        self.acceptQuatation(quotationId: self.pendingQuatationDatasource[indexPath.row].quatationId)
    }
    
    func rejectButton(cell: PendingQuatationCell) {
        guard let indexPath = self.pendingQuatationTableView.indexPath(for: cell) else { return }
        
        self.rejectQuatation(quotationId: self.pendingQuatationDatasource[indexPath.row].quatationId)
    }
}

//extension AdminPendingQuatationViewController: PendingQuatationListDelegate {
//
//    func setPendingQuatations(quatation: [Quatations], vc: AdminQuataionViewController) {
//        self.pendingQuatationDatasource = quatation
//        self.pendingQuatationTableView.reloadData()
//    }
//}

//MARK:- Helper Method
extension AdminPendingQuatationViewController {
    
    func getPendingQuatation() {
        ServiceManager().processService(urlRequest: ComunicateService.Router.GetQuatationList()) { (isSuccess, error , responseData) in
            if isSuccess {
                ServiceManagerModel().processQuatation(json: responseData, completion: { (isComplete, products) in
                    if isComplete {
//                        self.pendingQuatationDatasource = products!
                        
                        self.pendingQuatationDatasource = products!.filter({ (quotation) -> Bool in
                            quotation.status == 0
                        })
                        
                        self.pendingQuatationTableView.reloadData()
                    } else {
                        
                    }
                })
            } else {
                error?.configToast(isError: true)
            }
        }
    }
    
    func acceptQuatation(quotationId: Int?) {
        
        guard let id = quotationId else { return }
        
        let params = [Constant.c_req_quotation_id: "\(id)"]
        
        ServiceManager().processService(urlRequest: ComunicateService.Router.AcceptQuatation(params)) { (isSuccess, error , responseData) in
            if isSuccess {
//                print(responseData)
                self.getPendingQuatation()
            } else {
                error?.configToast(isError: true)
            }
        }
    }
    
    func rejectQuatation(quotationId: Int?) {
        
        guard let id = quotationId else { return }
        
        let params = [Constant.c_req_quotation_id: "\(id)"]
        
        ServiceManager().processService(urlRequest: ComunicateService.Router.RejectQuatation(params)) { (isSuccess, error , responseData) in
            if isSuccess {
//                print(responseData)
                self.getPendingQuatation()
            } else {
                error?.configToast(isError: true)
            }
        }
    }
}
