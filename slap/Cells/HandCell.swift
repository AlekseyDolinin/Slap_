import UIKit

class HandCell: UICollectionViewCell {
    
    @IBOutlet weak var handImage: UIImageView!

    var handIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell() {
        handImage.image = UIImage(named: "hand_\(handIndex)")
    }
}
