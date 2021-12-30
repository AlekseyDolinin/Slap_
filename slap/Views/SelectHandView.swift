import UIKit

class SelectHandView: UIView {
        
    @IBOutlet weak var topCollection: UICollectionView!
    @IBOutlet weak var bottomCollection: UICollectionView!
    @IBOutlet weak var topCollectionPreviousButton: UIButton!
    @IBOutlet weak var topCollectionNextButton: UIButton!
    @IBOutlet weak var bottomCollectionPreviousButton: UIButton!
    @IBOutlet weak var bottomCollectionNextButton: UIButton!
    @IBOutlet weak var iconTopReady: UIImageView!
    @IBOutlet weak var iconBottomReady: UIImageView!
    
    var selectIndexHandTop = 0
    var selectIndexHandBottom = 0
    var countHand: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    // показ и скрытие переключателей рук
    // при крайних положениях скрываются кнопки далее
    func checkButton() {
        topCollectionPreviousButton.alpha = selectIndexHandTop == 0 ? 0.2 : 1
        topCollectionNextButton.alpha = selectIndexHandTop == (countHand - 1) ? 0.2 : 1
        bottomCollectionPreviousButton.alpha = selectIndexHandBottom == 0 ? 0.2 : 1
        bottomCollectionNextButton.alpha = selectIndexHandBottom == (countHand - 1) ? 0.2 : 1
        
        setLockIconToHand()
    }
    
    //
    func setLockIconToHand() {
        
        if StoreManager.isFullVersion() {
            iconTopReady.image = UIImage(named: "checkIcon")
            iconBottomReady.image = UIImage(named: "checkIcon")
            return
        }
        
        if selectIndexHandTop > 2 {
            iconTopReady.isHidden = false
        }
        
        if selectIndexHandBottom > 2 {
            iconBottomReady.isHidden = false
        }
        
        iconTopReady.image = UIImage(named: selectIndexHandTop < 3 ? "checkIcon" : "lockIcon")
        iconBottomReady.image = UIImage(named: selectIndexHandBottom < 3 ? "checkIcon" : "lockIcon")
    }
}

extension SelectHandView {
    //
    func setUI() {
        topCollection.automaticallyAdjustsScrollIndicatorInsets = false
        bottomCollection.automaticallyAdjustsScrollIndicatorInsets = false
        topCollection.transform = CGAffineTransform(rotationAngle: .pi)
        iconTopReady.transform = CGAffineTransform(rotationAngle: .pi)
        topCollectionPreviousButton.alpha  = 0.2
        bottomCollectionPreviousButton.alpha  = 0.2
        //
        iconTopReady.isHidden = true
        iconBottomReady.isHidden = true
    }
}
