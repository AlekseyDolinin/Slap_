import UIKit

class SplashViewController: GeneralViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var versionLabel: UILabel!
    
    let priceManager = PriceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nsObject: AnyObject? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject
        let version = nsObject as! String
        versionLabel.text = "Version " + String(version)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// получение цен покупок
        priceManager.getPricesForInApps(inAppsIDs: [handSlapFullVersionID])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.logoImage.alpha = 0
                self.versionLabel.alpha = 0
            }) { (bool) in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }

}
