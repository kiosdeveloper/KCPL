
import UIKit

class leftMenuViewController: AbstractVC, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet var tblView: UITableView!
    
    @IBOutlet var viewHeader: UIView!
    
    @IBOutlet var lblUserName: UILabel!
    
    @IBOutlet var lblPointsCount: UILabel!
    
    @IBOutlet var imgUser: UIImageView!
    
    @IBOutlet var tblTrailConstraints: NSLayoutConstraint!
    
    let dsTitle = ["Home","Order History","About","Contact Us", "Visit Our Website", "Sign Out"]
    
//    let dsMenuImage = [UIImage(named: "side_myReservations"),UIImage(named: "side_myFavorites"),UIImage(named: "side_recentlyViewed"),UIImage(named: "side_setting"),UIImage(named: "side_contactUs"),UIImage(named: "side_privacyPolicy"),UIImage(named: "side_rateUs"),UIImage(named: "side_logout")]

    override func viewDidLoad() {
        
        //        lblUserName.text = "Me"
//        viewHeader.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        
        self.viewHeader.backgroundColor = ConstantsUI.C_Color_Theme

        tblView.backgroundColor = UIColor.clear
        
        tblView.rowHeight = UITableViewAutomaticDimension
        tblView.estimatedRowHeight = 44
        
        self.configHeader()
                
        self.reloadTableview()
    }
    
    
    // For tableview display for both landscape and portrate also.
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) { //if phone is in landscape
            self.tblTrailConstraints.constant = UIScreen.main.bounds.size.width * 0.5
        } else { //if phone is in portrait
            self.tblTrailConstraints.constant = UIScreen.main.bounds.size.width * 0.25
        }
        
    }
    
    @objc func reloadTableview() {
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.reloadData()
    }
    
    func configHeader() {
//        if let user = UserDefault.getUser() {
//
//            lblUserName.text = user.name
//
//            guard let profileImage = user.photo else { return }
//            self.imgUser.sd_setImage(with: URL(string: profileImage), placeholderImage: UIImage(named: "avatar"))
//        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dsTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tblView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
        
        cell.lblMenuTitle.text = dsTitle[indexPath.row]
        
        if indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 5 {
            cell.lblLine.isHidden = true
        } else {
            cell.lblLine.isHidden = false
        }

        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
////        if indexPath.row == 0 {
////            return 61
////        } else {
////            return 51
////        }
//        return UITableViewAutomaticDimension
//    }
    
    /*
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.tblView.frame.width, height: 100))
//        view.backgroundColor = themeBlueColor
//        return view
//    }
//    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 100
//    }*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        if indexPath.row == 0 {
            let vc = AppRouter.sharedRouter().getViewController("DashboardVC") as! DashboardVC
            
            SlideNavigationController.sharedInstance().pushViewController(vc, animated: false)

        } else if indexPath.row == 1 {//Order History
            let vc = AppRouter.sharedRouter().getViewController("OrderHistoryVC") as! OrderHistoryVC
            
            SlideNavigationController.sharedInstance().pushViewController(vc, animated: false)
        }
        /*if indexPath.section == 0 {
            let vc = AppRouter.sharedRouter().getViewController("TaskVC") as! TaskVC

            vc.selectedProject = projectDataSource[indexPath.row]
        SlideNavigationController.sharedInstance().pushViewController(vc, animated: false)
            
        } else {
            if indexPath.row == 1 {
                
                let alert = UIAlertController(title: nil, message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (action) in
                    print("Logout...")
                    Util.Logout()
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                if let popoverController = alert.popoverPresentationController {
                    popoverController.sourceView = self.view
                    popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                    popoverController.permittedArrowDirections = []
                }

                
                let appDelegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
                
                appDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
                
            }
        }*/
        
        
        /*switch indexPath.row {
        case 0:// MyReservation
//            let vc = AppRouter.sharedRouter().getViewController("MyReservationVC") as! MyReservationVC
//
//            SlideNavigationController.sharedInstance().pushViewController(vc, animated: false)
            break
            
        case 1:// MyFavorites
//            let vc = AppRouter.sharedRouter().getViewController("MyFavoritesVC") as! MyFavoritesVC
//
//            SlideNavigationController.sharedInstance().pushViewController(vc, animated: false)
            break
            
        
        case 2:// RecentlyViewed
//            let vc = AppRouter.sharedRouter().getViewController("RecentlyViewedVC") as! RecentlyViewedVC
//
//            SlideNavigationController.sharedInstance().pushViewController(vc, animated: false)
            break
            
        case 3:// Logout
            
//            UserDefaults.standard.removeObject(forKey: "user")
//            UserDefaults.standard.removeObject(forKey: "isLogin")
//            
//            let vc = AppRouter.sharedRouter().getViewController("LoginViewController") as! LoginViewController
//            
//            navigateView(to: vc)
            
            break
            
        default:
            break
        }*/
//        If Animation True Then Display first all page then pop
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 122.0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return self.viewHeader
        } else {
            return nil
        }
    }
    
    func navigateView(to viewController: UIViewController) {
        SlideNavigationController.sharedInstance().popToRootAndSwitch(to: viewController, withSlideOutAnimation: false, andCompletion: nil)
    }
    
//    MARK: Button Actions
 
//    @IBAction func btnEditPressed(_ sender: Any) {
////        let vc = AppRouter.sharedRouter().getViewController("ProfileVC") as! ProfileVC
////
////        SlideNavigationController.sharedInstance().pushViewController(vc, animated: false)
//    }
}

class MenuCell: UITableViewCell {

    @IBOutlet weak var imgMenuIcon: UIImageView!
    
    @IBOutlet weak var lblMenuTitle: UILabel!
    @IBOutlet var lblLine: UILabel!
}
