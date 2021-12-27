import UIKit
import GoogleMobileAds

class StartViewController: GeneralViewController, GADBannerViewDelegate {

    var viewSelf: StartView! {
        guard isViewLoaded else {return nil}
        return (view as! StartView)
    }
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setGadBanner()
    }
    
    @IBAction func goToSelectHand(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectHandViewController") as! SelectHandViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //
    @IBAction func showMenu(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuAppViewController") as! MenuAppViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
}
