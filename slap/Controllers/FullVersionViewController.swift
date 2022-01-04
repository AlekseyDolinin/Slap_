import UIKit

class FullVersionViewController: UIViewController {

    var viewSelf: FullVersionView! {
        guard isViewLoaded else { return nil }
        return (view as! FullVersionView)
    }
    
    var storeManager = StoreManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: nTransactionFailed, object: nil, queue: nil) { notification in
            
            let alert = UIAlertController(title: "Error", message: "Please try later", preferredStyle: .alert)
            let action = UIAlertAction(title: "Close", style: .default) { (action) in
                self.viewSelf.hideLoader()
            }
            alert.addAction(action)
            
            self.present(alert, animated: true) {
                
            }
        }
    }
    
    
    ///
    func getFullVersion() {
        print("getFullVersion")
        storeManager.buyInApp(inAppID: handSlapFullVersionID)
    }
    
    ///
    func restorePurshase() {
        print("restorePurshase")
        storeManager.restorePurchase()
    }
    
    //
    @IBAction func getFullVersion(_ sender: Any) {
        viewSelf.showLoader()
        if StoreManager.isFullVersion() == false {
            getFullVersion()
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//            self.dismiss(animated: true)
//        }
    }
    
    //
    @IBAction func restorePurshase(_ sender: Any) {
        viewSelf.showLoader()
        if StoreManager.isFullVersion() == false {
            restorePurshase()
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//            self.dismiss(animated: true)
//        }
    }
    
    //
    @IBAction func back(_ sender: Any) {
        dismiss(animated: false)
    }
}




import UIKit

class FullVersionView: UIView {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var contentView: UIView!
    
    override func awakeFromNib() {
        setUI()
    }
    
    ///
    func showLoader() {
        contentView.alpha = 0.3
        loader.startAnimating()
        isUserInteractionEnabled = false
    }
    
    ///
    func hideLoader() {
        contentView.alpha = 1.0
        loader.stopAnimating()
        isUserInteractionEnabled = true
    }
}

extension FullVersionView {
    
    func setUI() {
        
        
        ///
        loader.stopAnimating()
    }
}
