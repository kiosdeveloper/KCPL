//
//  AdminQuatationViewController.swift
//  KCPL
//
//  Created by TechFlitter Solutions on 12/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class AdminQuatationDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var rejectButton: UIButton!
    
    @IBOutlet weak var acceptButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rejectButton.layer.borderColor = ConstantsUI.C_Color_Theme.cgColor
        self.rejectButton.layer.borderWidth = 1.0
        self.rejectButton.clipsToBounds = true
        self.nameLabel.text = "Karnavati Corp. Pvt. Ltd.\nMr. Paresh Patel"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Quatation Detail"
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
}

extension AdminQuatationDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuatationDetailCell", for: indexPath) as! QuatationDetailCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
