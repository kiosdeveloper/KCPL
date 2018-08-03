//
//  AdminHistoryQuatationViewController.swift
//  KCPL
//
//  Created by Piyush Sanepara on 08/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminHistoryQuatationViewController: UIViewController {

    var pastQuatationDatasource = [Quatations]()

    @IBOutlet var historyQuatationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
        historyQuatationTableView.register(UINib.init(nibName: "HistoryQuatationCell", bundle: nil), forCellReuseIdentifier: "HistoryQuatationCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getQuatationHistory()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAdminQuatationDetailFromAdminHistoryQuatation" {
            if let toVC = segue.destination as? AdminQuatationDetailViewController, let indexPath = sender as? IndexPath {
                toVC.quatation = self.pastQuatationDatasource[indexPath.row]
                toVC.fromScreenType = ScreenType.AdminHistoryQuatationScreen
            }
        }
    }
}

extension AdminHistoryQuatationViewController: UITableViewDelegate, UITableViewDataSource, HistoryQuatationDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.pastQuatationDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = historyQuatationTableView.dequeueReusableCell(withIdentifier: "HistoryQuatationCell") as! HistoryQuatationCell
        cell.delegate = self
        cell.setDataSource(quatation: self.pastQuatationDatasource[indexPath.row])
        cell.configReaaceptButtonRejectLabel(status: self.pastQuatationDatasource[indexPath.row].status ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showAdminQuatationDetailFromAdminHistoryQuatation", sender: indexPath)
    }
    
    func reAcceptButton(cell: HistoryQuatationCell) {
        guard let indexPath = self.historyQuatationTableView.indexPath(for: cell) else { return }
        
        self.reAcceptQuatation(quotationId: self.pastQuatationDatasource[indexPath.row].quatationId)
    }
}

//extension AdminHistoryQuatationViewController: PastQuatationListDelegate {
//    func setQuatationHistory(quatation: [Quatations], vc: AdminQuataionViewController) {
//        self.pastQuatationDatasource = quatation
//        self.historyQuatationTableView.reloadData()
//    }
//}

extension AdminHistoryQuatationViewController {
    
    func getQuatationHistory() {
        ServiceManager().processService(urlRequest: ComunicateService.Router.GetQuatationList()) { (isSuccess, error , responseData) in
            if isSuccess {
                ServiceManagerModel().processQuatation(json: responseData, completion: { (isComplete, products) in
                    if isComplete {
//                        self.pastQuatationDatasource = products!
                        self.pastQuatationDatasource = products!.filter({ (quotation) -> Bool in
                            quotation.status != 0
                        })
                        
                        self.historyQuatationTableView.reloadData()
                    } else {
                        
                    }
                })
            } else {
                error?.configToast(isError: true)
            }
        }
    }
    
    func reAcceptQuatation(quotationId: Int?) {
        
        guard let id = quotationId else { return }
        
        let params = [Constant.c_req_quotation_id: "\(id)"]
        
        ServiceManager().processService(urlRequest: ComunicateService.Router.AcceptQuatation(params)) { (isSuccess, error , responseData) in
            if isSuccess {
                //                print(responseData)
                self.getQuatationHistory()
            } else {
                error?.configToast(isError: true)
            }
        }
    }
}
