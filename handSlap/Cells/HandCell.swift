import UIKit

class HandCell: UICollectionViewCell {
    
    @IBOutlet weak var handImage: UIImageView!

    var hand: Hand!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    func setCell() {
        handImage.image = UIImage(named: "\(hand.name)")
        
        
        
    }
}

extension HandCell {
    ///
    func setUI() {
                
    }
}
