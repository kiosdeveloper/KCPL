//
//  AdminQuataionViewController.swift
//  KCPL
//
//  Created by Piyush Sanepara on 08/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminQuataionViewController: UIViewController {
    
    @IBOutlet weak var quatationTableView: UITableView!
    
    var productsDatasource = [Quatations]()
    var pendingQuatation = [Quatations]()
    var pastQuatation = [Quatations]()

    var isHistory = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quatationTableView.register(UINib.init(nibName: "HistoryQuatationCell", bundle: nil), forCellReuseIdentifier: "HistoryQuatationCell")
        quatationTableView.register(UINib.init(nibName: "PendingQuatationCell", bundle: nil), forCellReuseIdentifier: "PendingQuatationCell")
        self.getQuatationList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Quotation"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
//    MARK:- Actions
    
    @IBAction func quationSegmentValueChanged(_ sender: UISegmentedControl) {
        self.isHistory = sender.selectedSegmentIndex == 1
        self.reloadTableView(isScrollToTop: true)
    }
}

extension AdminQuataionViewController: AdminQuatationDetailViewControllerDelegate{
    func getQuatationList() {
        ServiceManager().processService(urlRequest: ComunicateService.Router.GetQuatationList()) { (isSuccess, error , responseData) in
            if isSuccess {
                ServiceManagerModel().processQuatation(json: responseData, completion: { (isComplete, products) in
                    if isComplete {
                        self.productsDatasource = products!
                        self.quatationListProcess()
                        self.reloadTableView(isScrollToTop: false)
                    }
                })
            } else {
                error?.configToast(isError: true)
            }
        }
    }
    
    func quatationListProcess() {
        self.pastQuatation = self.productsDatasource.filter({ (quotation) -> Bool in
            quotation.status != 0
        })
        self.pendingQuatation = self.productsDatasource.filter({ (quotation) -> Bool in
            quotation.status == 0
        })
    }
    
    func reloadTableView(isScrollToTop: Bool) {
        self.quatationTableView.reloadData()
        if isScrollToTop {
            if self.pendingQuatation.count > 0 && self.pastQuatation.count > 0 {
                let indexPath = IndexPath(row: 0, section: 0)
                self.quatationTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
    }
    
    //    Delegate Method for reload
    func needToReload() {
        self.getQuatationList()
    }
    
    //    MARK:- Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuatationDetailFromAdminQuatation" {
            if let toVC = segue.destination as? AdminQuatationDetailViewController, let indexPath = sender as? IndexPath  {
                if self.isHistory {
                    toVC.delegate = self
                    toVC.quatation = self.pastQuatation[indexPath.row]
                    toVC.fromScreenType = ScreenType.AdminHistoryQuatationScreen
                }
                else {
                    toVC.delegate = self
                    toVC.quatation = self.pendingQuatation[indexPath.row]
                    toVC.fromScreenType = ScreenType.AdminPendingQuatationScreen
                }
            }
        }
    }
}

extension AdminQuataionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isHistory {
            return self.pastQuatation.count
        }
        return self.pendingQuatation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isHistory {
            let cell = self.quatationTableView.dequeueReusableCell(withIdentifier: "HistoryQuatationCell") as! HistoryQuatationCell
            cell.delegate = self
            cell.setDataSource(quatation: self.pastQuatation[indexPath.row])
            cell.configReaaceptButtonRejectLabel(status: self.pastQuatation[indexPath.row].status ?? 0)
            return cell
        }
        else {
            let cell = self.quatationTableView.dequeueReusableCell(withIdentifier: "PendingQuatationCell") as! PendingQuatationCell
            cell.delegate = self
            cell.setDataSource(quatation: self.pendingQuatation[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showQuatationDetailFromAdminQuatation", sender: indexPath)
    }
}

extension AdminQuataionViewController: PendingQuatationDelegate {
    func acceptButton(cell: PendingQuatationCell) {
        guard let indexPath = self.quatationTableView.indexPath(for: cell) else { return }
        self.acceptQuatation(quotationId: self.pendingQuatation[indexPath.row].quatationId)
    }
    
    func rejectButton(cell: PendingQuatationCell) {
        guard let indexPath = self.quatationTableView.indexPath(for: cell) else { return }
        self.rejectQuatation(quotationId: self.pendingQuatation[indexPath.row].quatationId)
    }
    
    func acceptQuatation(quotationId: Int?) {
        guard let id = quotationId else { return }
        let params = [Constant.c_req_quotation_id: "\(id)"]
        ServiceManager().processService(urlRequest: ComunicateService.Router.AcceptQuatation(params)) { (isSuccess, error , responseData) in
            if isSuccess {
                self.getQuatationList()
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
                self.getQuatationList()
            } else {
                error?.configToast(isError: true)
            }
        }
    }
}

extension AdminQuataionViewController: HistoryQuatationDelegate {
    func reAcceptQuatation(quotationId: Int?) {
        guard let id = quotationId else { return }
        let params = [Constant.c_req_quotation_id: "\(id)"]
        ServiceManager().processService(urlRequest: ComunicateService.Router.AcceptQuatation(params)) { (isSuccess, error , responseData) in
            if isSuccess {
                self.getQuatationList()
            } else {
                error?.configToast(isError: true)
            }
        }
    }
    
    func reAcceptButton(cell: HistoryQuatationCell) {
        guard let indexPath = self.quatationTableView.indexPath(for: cell) else { return }
        self.reAcceptQuatation(quotationId: self.pastQuatation[indexPath.row].quatationId)
    }
}

extension AdminQuataionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.pendingQuatation.removeAll()
        self.pastQuatation.removeAll()
        
        if searchText.count > 0 {
            self.quatationListProcess()
            self.pastQuatation = self.pastQuatation.filter { (order) -> Bool in
                if let user = order.user {
                    return "\(user.first_name ?? "")  \(user.last_name ?? "")".lowercased().contains(searchText.lowercased()) || "\(order.quatationId ?? 0)".contains(searchText)
                }
                return "\(order.quatationId ?? 0)".contains(searchText)
            }
            
            self.pendingQuatation = self.pendingQuatation.filter { (order) -> Bool in
                if let user = order.user {
                    return "\(user.first_name ?? "")  \(user.last_name ?? "")".lowercased().contains(searchText.lowercased()) || "\(order.quatationId ?? 0)".contains(searchText)
                }
                return "\(order.quatationId ?? 0)".contains(searchText)
            }
            self.reloadTableView(isScrollToTop: false)
        }
        else {
            self.quatationListProcess()
            self.reloadTableView(isScrollToTop: false)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        Util().configBarButtonColor(color: UIColor.white)
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.quatationListProcess()
        self.reloadTableView(isScrollToTop: false)

        searchBar.text = nil
        Util().configBarButtonColor(color: UIColor.clear)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
