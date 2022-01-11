import UIKit
import GoogleMobileAds

class FinalViewController: GeneralViewController, GADInterstitialDelegate {
    
    @IBOutlet weak var topImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var bottomImage: UIImageView!
    @IBOutlet weak var topButtonStack: UIStackView!
    @IBOutlet weak var bottomButtonStack: UIStackView!
    
    var playerWin: String!
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topImageConstraint.constant = topImageConstraint.constant - view.frame.width / 3
        bottomImageConstraint.constant = bottomImageConstraint.constant + view.frame.width / 3
        topImage.transform = CGAffineTransform(rotationAngle: .pi)
        topButtonStack.transform = CGAffineTransform(rotationAngle: .pi)
        setWinPlayer()
        
        if StoreManager.isFullVersion() == false {
            setGadFullView()
        }
    }
    
    //
    func setWinPlayer() {
        if playerWin == "Top" {
            topImage.image = UIImage(named: "winFinal")
            bottomImage.image = UIImage(named: "loseFinal")
        } else {
            topImage.image = UIImage(named: "loseFinal")
            bottomImage.image = UIImage(named: "winFinal")
        }
    }

    //
    @IBAction func revenge(_ sender: Any) {
        if interstitial.isReady == true {
            print("ролик готов")
            interstitial.present(fromRootViewController: self)
        } else {
            self.dismiss(animated: true) {
                NotificationCenter.default.post(name: self.nReloadRound, object: nil)
            }
        }
    }
    
    @IBAction func home(_ sender: Any) {
        dismiss(animated: false) {
            NotificationCenter.default.post(name: self.nBackHome, object: self)
        }
    }
}
