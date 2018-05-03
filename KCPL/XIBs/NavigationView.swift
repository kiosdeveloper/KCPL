import UIKit

class NavigationView: UIView {
    
    @IBOutlet var view: UIView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Bundle.main.loadNibNamed("NavigationView", owner: self, options: nil)
        self.view.backgroundColor = ConstantsUI.C_Color_Theme
        
        self.addSubview(view)
        view.frame = self.bounds
    }
}
