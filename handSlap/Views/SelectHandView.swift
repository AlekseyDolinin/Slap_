import UIKit

class SelectHandView: UIView {
        
    @IBOutlet weak var topConstaraint: NSLayoutConstraint!
    @IBOutlet weak var topCollection: UICollectionView!
    @IBOutlet weak var bottomCollection: UICollectionView!
    @IBOutlet weak var topStackButtons: UIStackView!
    @IBOutlet weak var bottomStackButtons: UIStackView!
    @IBOutlet weak var topCollectionPreviousButton: UIButton!
    @IBOutlet weak var topCollectionNextButton: UIButton!
    @IBOutlet weak var bottomCollectionPreviousButton: UIButton!
    @IBOutlet weak var bottomCollectionNextButton: UIButton!
    @IBOutlet weak var topContainerSelecHand: UIView!
    @IBOutlet weak var bottomContainerSelecHand: UIView!
    @IBOutlet weak var iconTopReady: UIImageView!
    @IBOutlet weak var iconBottomReady: UIImageView!
    @IBOutlet weak var topSelectButton: UIButton!
    @IBOutlet weak var bottomSelectButton: UIButton!
    
    var selectIndexHandTop = 0
    var selectIndexHandBottom = 0
    var listHand = [Hand]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        setConstraint()
    }
    
    ///
    func setConstraint() {
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 0.0
        topConstaraint.constant += topPadding / 2
    }
    
    // показ и скрытие переключателей рук
    // при крайних положениях скрываются кнопки далее
    func checkButton(indexHandTop: Int, indexHandBottom: Int) {
        topCollectionPreviousButton.alpha = indexHandTop == 0 ? 0.2 : 1
        topCollectionNextButton.alpha = indexHandTop == (listHand.count - 1) ? 0.2 : 1
        bottomCollectionPreviousButton.alpha = indexHandBottom == 0 ? 0.2 : 1
        bottomCollectionNextButton.alpha = indexHandBottom == (listHand.count - 1) ? 0.2 : 1
    }
    
    //
    func setContent() {
        setLockIconToHand()
        setTitle()
    }
    
    //
    func setLockIconToHand() {
        if selectIndexHandTop > 2 {
            iconTopReady.isHidden = false
        }
        iconTopReady.image = UIImage(named: selectIndexHandTop < 3 ? "checkIcon" : "lockIcon")
        
        if selectIndexHandBottom > 2 {
            iconBottomReady.isHidden = false
        }
        iconBottomReady.image = UIImage(named: selectIndexHandBottom < 3 ? "checkIcon" : "lockIcon")
    }
    
    //
    func setTitle() {
        let topTitle = selectIndexHandTop < 3 ? "Ready" : "Unlock"
        topSelectButton.setTitle(topTitle, for: .normal)
        let bottomTitle = selectIndexHandBottom < 3 ? "Ready" : "Unlock"
        bottomSelectButton.setTitle(bottomTitle, for: .normal)
    }
    
}

extension SelectHandView {
    ///
    func setUI() {
        topCollection.automaticallyAdjustsScrollIndicatorInsets = false
        bottomCollection.automaticallyAdjustsScrollIndicatorInsets = false
        topCollection.transform = CGAffineTransform(rotationAngle: .pi)
        topContainerSelecHand.transform = CGAffineTransform(rotationAngle: .pi)
        bottomCollectionPreviousButton.alpha  = 0.2
        topCollectionPreviousButton.alpha  = 0.2

        //
        iconTopReady.isHidden = true
        iconBottomReady.isHidden = true
        
        //
        topSelectButton.setTitle("Ready", for: .normal)
        bottomSelectButton.setTitle("Ready", for: .normal)
    }
}
