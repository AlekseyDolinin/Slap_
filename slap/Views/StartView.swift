import UIKit

class StartView: UIView {
    
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var fullVersionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
}

extension StartView {
    //
    func setUI() {
        
        startGameButton.transform = CGAffineTransform(translationX: 0, y: -frame.height)
        
        if StoreManager.isFullVersion() {
            fullVersionButton.isHidden = true
        }
        
        UIView.animate(withDuration: 0.8,
                       delay: 0.2,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.0,
                       options: [],
                       animations: {
            self.startGameButton.transform = .identity
        }) { _ in
            print("")
            print("_______________________________________")
            print("animation completed")
        }
    }
}
