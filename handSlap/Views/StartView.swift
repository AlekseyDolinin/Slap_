import UIKit

class StartView: UIView {
    
    @IBOutlet weak var startGameButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        startGameButton.transform = CGAffineTransform(translationX: 0, y: -frame.height)
        setUI()
    }
}

extension StartView {
    ///
    func setUI() {
        UIView.animate(withDuration: 1.0,
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
