import UIKit

class GameView: UIView {
    
    @IBOutlet weak var topDescription: UIView!
    @IBOutlet weak var bottomDescription: UIView!
    @IBOutlet weak var topDescriptionLabel: UILabel!
    @IBOutlet weak var bottomDescriptionLabel: UILabel!
    @IBOutlet weak var topConstaraint: NSLayoutConstraint!
    @IBOutlet weak var topStackFalseStart: UIStackView!
    @IBOutlet weak var bottomStackFalseStart: UIStackView!
    @IBOutlet weak var topIndicatorOne: UIImageView!
    @IBOutlet weak var topIndicatorTwo: UIImageView!
    @IBOutlet weak var topIndicatorThree: UIImageView!
    @IBOutlet weak var bottomIndicatorOne: UIImageView!
    @IBOutlet weak var bottomIndicatorTwo: UIImageView!
    @IBOutlet weak var bottomIndicatorThree: UIImageView!
    @IBOutlet weak var topArrowState: UIImageView!
    @IBOutlet weak var bottomArrowState: UIImageView!
    @IBOutlet weak var topConstr: NSLayoutConstraint!
    @IBOutlet weak var bottomConstr: NSLayoutConstraint!
    @IBOutlet weak var containerTopForLives: UIView!
    @IBOutlet weak var stackTopInd: UIStackView!
    @IBOutlet weak var topL1: UIImageView!
    @IBOutlet weak var topL2: UIImageView!
    @IBOutlet weak var topL3: UIImageView!
    @IBOutlet weak var topL4: UIImageView!
    @IBOutlet weak var topL5: UIImageView!
    @IBOutlet weak var topL6: UIImageView!
    @IBOutlet weak var topL7: UIImageView!
    @IBOutlet weak var topL8: UIImageView!
    @IBOutlet weak var topL9: UIImageView!
    @IBOutlet weak var topL10: UIImageView!
    @IBOutlet weak var containerBottomForLives: UIView!
    @IBOutlet weak var stackBottomInd: UIStackView!
    @IBOutlet weak var bottomL1: UIImageView!
    @IBOutlet weak var bottomL2: UIImageView!
    @IBOutlet weak var bottomL3: UIImageView!
    @IBOutlet weak var bottomL4: UIImageView!
    @IBOutlet weak var bottomL5: UIImageView!
    @IBOutlet weak var bottomL6: UIImageView!
    @IBOutlet weak var bottomL7: UIImageView!
    @IBOutlet weak var bottomL8: UIImageView!
    @IBOutlet weak var bottomL9: UIImageView!
    @IBOutlet weak var bottomL10: UIImageView!
    
    var game: Game!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        setConstraint()
    }

    func setConstraint() {
        topConstr.constant = frame.height / 3
        bottomConstr .constant = frame.height / 3
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            let topPadding = window?.safeAreaInsets.top ?? 0.0
            topConstaraint.constant += topPadding / 2
        }
    }
    
    //
    func updateGame() {
        
        setDescription()
        updateIndicatorsLives()
                
        // поворот стрелки атаки/защиты
        topArrowState.transform = game.sideAttack == .bottomHandAttack ? CGAffineTransform(rotationAngle: .pi) : .identity
        bottomArrowState.transform = game.sideAttack == .bottomHandAttack ? CGAffineTransform(rotationAngle: .pi) : .identity
        
        topStackFalseStart.isHidden = game.sideAttack == .bottomHandAttack ? false : true
        bottomStackFalseStart.isHidden = game.sideAttack == .bottomHandAttack ? true : false
    }
    
    func setDescription() {
        if game.sideAttack == .bottomHandAttack {
            topDescriptionLabel.text = "defense"
            bottomDescriptionLabel.text = "Attack"
        } else {
            topDescriptionLabel.text = "Attack"
            bottomDescriptionLabel.text = "defense"
        }
    }
    
    //
    func updateIndicatorsLives() {
        if game.pointTopHand == 0 && game.pointBottomHand == 0 {
            for i in stackTopInd.arrangedSubviews {
                i.alpha = 1.0
            }
            for i in stackBottomInd.arrangedSubviews {
                i.alpha = 1.0
            }
        } else {
            for i in stackTopInd.arrangedSubviews {
                if i.tag == game.pointBottomHand {
                    i.alpha = 0.5
                }
            }
            for i in stackBottomInd.arrangedSubviews {
                if i.tag == game.pointTopHand {
                    i.alpha = 0.5
                }
            }
        }
    }
    
    //
    func updateFalseStartIndicator() {
        
        if game.sideAttack == .bottomHandAttack {
            switch game.falseStartCount {
            case 1:
                topIndicatorOne.alpha = 0.2
            case 2:
                topIndicatorTwo.alpha = 0.2
            case 3:
                topIndicatorThree.alpha = 0.2
            default:
                break
            }
        }
        
        if game.sideAttack == .topHandAttack {
            switch game.falseStartCount {
            case 1:
                bottomIndicatorOne.alpha = 0.2
            case 2:
                bottomIndicatorTwo.alpha = 0.2
            case 3:
                bottomIndicatorThree.alpha = 0.2
            default:
                break
            }
        }
        
        if game.falseStartCount == 3 {
            if game.sideAttack == .bottomHandAttack {
                topDescriptionLabel.text = "lock"
            } else {
                bottomDescriptionLabel.text = "lock"
            }
        }
    }
    
    //
    func showAllIndicatorsFalseStart() {
        topIndicatorThree.alpha = 1.0
        topIndicatorTwo.alpha = 1.0
        topIndicatorOne.alpha = 1.0
        bottomIndicatorThree.alpha = 1.0
        bottomIndicatorTwo.alpha = 1.0
        bottomIndicatorOne.alpha = 1.0
    }
    
}

extension GameView {
    ///
    func setUI() {
        
        topArrowState.layer.compositingFilter = "multiplyBlendMode"
        bottomArrowState.layer.compositingFilter = "multiplyBlendMode"
        topArrowState.alpha = 0.5
        bottomArrowState.alpha = 0.5
        
        topStackFalseStart.layer.compositingFilter = "multiplyBlendMode"
        topStackFalseStart.alpha = 0.75
        
        bottomStackFalseStart.layer.compositingFilter = "multiplyBlendMode"
        bottomStackFalseStart.alpha = 0.75
        
        topStackFalseStart.transform = CGAffineTransform(rotationAngle: .pi)
        topDescription.transform = CGAffineTransform(rotationAngle: .pi)
    }
}
