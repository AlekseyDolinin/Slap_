import UIKit

class GeneralViewController: UIViewController {
    
    override var shouldAutorotate: Bool { return false }
    override var prefersStatusBarHidden: Bool { return true }
    
    let nReloadRound: NSNotification.Name = NSNotification.Name(rawValue: "nReloadRound")
    let nBackHome: NSNotification.Name = NSNotification.Name(rawValue: "nBackHome")
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

}
