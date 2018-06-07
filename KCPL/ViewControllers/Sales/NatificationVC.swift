//
//  NatificationVC.swift
//  KCPL
//
//  Created by Piyush Sanepara on 07/06/18.
//  Copyright © 2018 KCPL. All rights reserved.
//

import UIKit

class NatificationVC: AbstractVC {

    @IBOutlet var notificationTableview: ThemeTableView!
    var notificationDatasource = ["Notification 1", "Notification 2", "Notification 3", "Notification 4", "Notification 5", "Notification 6", "Notification 7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = ConstantsUI.C_Color_ThemeLightGray
    }
}

extension NatificationVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return notificationDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = notificationTableview.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
        
        cell.notificationLabel.text = notificationDatasource[indexPath.row]
        
        return cell
    }
    
}
