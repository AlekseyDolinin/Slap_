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
    
    var countHand: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    //
    func checkButtonTop(selectIndexHandTop: Int) {
        iconTopReady.image = UIImage(named: selectIndexHandTop > 2 ? "lockIcon" : "checkIcon")
        topCollectionPreviousButton.alpha = selectIndexHandTop == 0 ? 0.2 : 1
        topCollectionNextButton.alpha = selectIndexHandTop == (countHand - 1) ? 0.2 : 1
        iconTopReady.isHidden = selectIndexHandTop > 2 ? false : true
    }
    
    //
    func checkButtonBottom(selectIndexHandBottom: Int) {
        iconBottomReady.image = UIImage(named: selectIndexHandBottom > 2 ? "lockIcon" : "checkIcon")
        bottomCollectionPreviousButton.alpha = selectIndexHandBottom == 0 ? 0.2 : 1
        bottomCollectionNextButton.alpha = selectIndexHandBottom == (countHand - 1) ? 0.2 : 1
        iconBottomReady.isHidden = selectIndexHandBottom > 2 ? false : true
    }
}

extension SelectHandView {
    //
    func setUI() {
        topCollection.automaticallyAdjustsScrollIndicatorInsets = false
        bottomCollection.automaticallyAdjustsScrollIndicatorInsets = false
        topCollection.transform = CGAffineTransform(rotationAngle: .pi)
        iconTopReady.transform = CGAffineTransform(rotationAngle: .pi)
        topCollectionPreviousButton.alpha = 0.2
        bottomCollectionPreviousButton.alpha = 0.2
        
        //
        iconTopReady.isHidden = true
        iconBottomReady.isHidden = true
    }
}
