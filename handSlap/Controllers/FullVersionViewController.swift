import UIKit

class FullVersionViewController: UIViewController {

    var viewSelf: FullVersionView! {
        guard isViewLoaded else { return nil }
        return (view as! FullVersionView)
    }
    
    var storeManager = StoreManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    ///
    func getFullVersion() {
        print("getFullVersion")
        storeManager.buyInApp(inAppID: handSlapFullVersionID)
    }
    
    @IBAction func getFullVersion(_ sender: Any) {
        viewSelf.showLoader()
        
        if !StoreManager.isFullVersion() {
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
    
    override func awakeFromNib() {
        setUI()
    }
    
    
    func configure() {
    }
    
    ///
    func showLoader() {
//        menuTable.alpha = 0.3
        loader.startAnimating()
        isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            self.menuTable.alpha = 1.0
            self.loader.stopAnimating()
            self.isUserInteractionEnabled = true
        }
    }
}

extension FullVersionView {
    
    func setUI() {
        
        
        ///
        loader.stopAnimating()
    }
}
