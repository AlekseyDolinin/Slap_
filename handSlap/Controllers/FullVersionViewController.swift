import UIKit

class FullVersionViewController: UIViewController {

    var viewSelf: FullVersionView! {
        guard isViewLoaded else { return nil }
        return (view as! FullVersionView)
    }
    
    var storeManager = StoreManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ///
        NotificationCenter.default.addObserver(forName: nTransactionFailed, object: nil, queue: nil) { notification in
            self.viewSelf.hideLoader()
        }
    }
    
    
    ///
    func getFullVersion() {
        print("getFullVersion")
        storeManager.buyInApp(inAppID: handSlapFullVersionID)
    }
    
    @IBAction func getFullVersion(_ sender: Any) {
        viewSelf.showLoader()
        if StoreManager.isFullVersion() == false {
            getFullVersion()
        }
    }
    
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
    
    
    func configure() {
        
    }
    
    ///
    func showLoader() {
        contentView.alpha = 0.3
        loader.startAnimating()
        isUserInteractionEnabled = false
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//            self.hideLoader()
//        }
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
