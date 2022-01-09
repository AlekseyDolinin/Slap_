import UIKit
import SpriteKit
import AudioToolbox

class GameViewController: GeneralViewController {
    
    @IBOutlet weak var viewScene: SKView!
    
    var viewSelf: GameView! {
        guard isViewLoaded else {return nil}
        return (view as! GameView)
    }
    
    var game: Game!
    var lockHand = false
    var topHandIndex = 0
    var bottomHandIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = viewScene {
            let scene = GameScene(size: viewScene.frame.size)
            scene.scaleMode = .aspectFill
            scene.gameVC = self
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = true
        }
        createGame()
        
        NotificationCenter.default.addObserver(forName: nReloadRound, object: nil, queue: nil) { notification in
            self.createGame()
        }
        
        NotificationCenter.default.addObserver(forName: nBackHome, object: nil, queue: nil) { notification in
            self.outGame()
        }
        
        if SettingApp.isSoundOn() {
            Sound.setSlapEffect()
            Sound.setLockEffect()
        }
        
    }
    
    deinit {
        print("deinit GameViewController")
        Sound.removePlayers()
    }
    
    
    //
    func createGame() {
        view.isUserInteractionEnabled = true
        game = Game(id: UUID().uuidString.lowercased(),
                    pointTopHand: 0,
                    pointBottomHand: 0,
                    falseStartCount: 0,
                    sideAttack: .bottomHandAttack)
        viewSelf.game = game
        updateGame()
    }
    
    func updateGame() {
        viewSelf.game = game
        viewSelf.updateGame()
        //
        if game.pointTopHand == 10 || game.pointBottomHand == 10 {
            view.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FinalViewController") as! FinalViewController
                vc.playerWin = self.game.pointTopHand == 10 ? "Top" : "Bottom"
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: false)
            }
        }
    }
    
    //
    func shake() {
        if SettingApp.isSoundOn() {
            Sound.playerSlapEffect?.play()
        }
        if SettingApp.isVibrationOn() {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.03
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 10, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 10, y: view.center.y))
        view.layer.add(animation, forKey: "position")
    }
    
    //
    func updateFalseStartCount() {
        game.falseStartCount += 1
        viewSelf.game = game
        viewSelf.updateFalseStartIndicator()
        // блокировка руки
        if game.falseStartCount == 3 {
            lockHand = true
            //звук блокировки руки
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                if SettingApp.isSoundOn() {
                    Sound.playerLockEffect?.play()
                }
            }
        }
    }
    
    func showAllIndicatorsFalseStart() {
        lockHand = false
        game.falseStartCount = 0
        viewSelf.showAllIndicatorsFalseStart()
    }
    
    //
    func outGame() {
        if let vcs = navigationController?.viewControllers {
            for vc in vcs {
                if vc.restorationIdentifier == "StartViewController" {
                    navigationController?.popToViewController(vc, animated: true)
                }
            }
        }
    }
    
    //
    @IBAction func showMenu(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuGameViewController") as! MenuGameViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
}
