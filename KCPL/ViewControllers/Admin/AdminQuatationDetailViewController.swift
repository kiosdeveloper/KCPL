//
//  AdminQuatationViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 12/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

protocol AdminQuatationDetailViewControllerDelegate: class {
    func needToReload()
}

class AdminQuatationDetailViewController: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var orderIdLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var rejectButton: UIButton!
    
    @IBOutlet weak var acceptButton: UIButton!
    
    @IBOutlet var reacceptButton: UIButton!
    
    @IBOutlet var tableViewBottomConstraints: NSLayoutConstraint!
    
    var quatation = Quatations()
    
    var fromScreenType: ScreenType?
    
    var delegate: AdminQuatationDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rejectButton.layer.borderColor = ConstantsUI.C_Color_Theme.cgColor
        self.rejectButton.layer.borderWidth = 1.0
        self.rejectButton.clipsToBounds = true
        self.addressLabel.text = self.quatation.billToAddress ?? "No Address available"
        self.orderIdLabel.text = "Order #\(self.quatation.quatationId ?? 0)"
        self.timeLabel.text = self.quatation.createdAt!.convertOrderCreatedDate().getElapsedInterval()
        
        self.configActionButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Quotation Detail"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    func configActionButton() {
        reacceptButton.isHidden = !(fromScreenType == ScreenType.AdminHistoryQuatationScreen)
        
        rejectButton.isHidden = !(fromScreenType == ScreenType.AdminPendingQuatationScreen)
        
        acceptButton.isHidden = !(fromScreenType == ScreenType.AdminPendingQuatationScreen)
        
        if fromScreenType == ScreenType.AdminHistoryQuatationScreen,!reacceptButton.isHidden, let status = quatation.status {
            reacceptButton.isHidden = !(status < 0)
            self.tableViewBottomConstraints.constant = reacceptButton.isHidden ? -50 : 0
        }
    }
    
//    MARK:- Actions
    @IBAction func acceptButtonPressed(_ sender: Any) {
        self.acceptQuatation(quotationId: quatation.quatationId)
    }
    
    @IBAction func rejectButtonPressed(_ sender: Any) {
        self.rejectQuatation(quotationId: quatation.quatationId)
    }
    
    @IBAction func reacceptButtonPressed(_ sender: Any) {
        self.acceptQuatation(quotationId: quatation.quatationId)
    }
}

//MARK:- Helper Method
extension AdminQuatationDetailViewController {
    
    func acceptQuatation(quotationId: Int?) {
        
        guard let id = quotationId else { return }
        
        let params = [Constant.c_req_quotation_id: "\(id)"]
        
        ServiceManager().processService(urlRequest: ComunicateService.Router.AcceptQuatation(params)) { (isSuccess, error , responseData) in
            if isSuccess {
                //                print(responseData)
                
                self.delegate?.needToReload()
                
                self.navigationController?.popViewController(animated: true)
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
                
                self.delegate?.needToReload()
                
                self.navigationController?.popViewController(animated: true)
            } else {
                error?.configToast(isError: true)
            }
        }
    }
}

extension AdminQuatationDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quatation.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuatationDetailCell", for: indexPath) as! QuatationDetailCell
        cell.setDataSource(product: self.quatation.products[indexPath.item])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
