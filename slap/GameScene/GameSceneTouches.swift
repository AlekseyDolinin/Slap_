import SpriteKit

extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let positionTouchY = t.location(in: self).y
            
            if positionTouchY < size.height / 2 {
                // touch bottom
                // блокировка руки
                if gameVC.game.sideAttack == .topHandAttack && gameVC.lockHand == true {
                    return
                }
                gameVC.game.sideAttack == .bottomHandAttack ? slapBottomHand() : hideBottomHand()
            }
            
            if positionTouchY > size.height / 2 {
                // touch top
                // блокировка руки
                if gameVC.game.sideAttack == .bottomHandAttack && gameVC.lockHand == true {
                    return
                }
                gameVC.game.sideAttack == .topHandAttack ? slapTopHand() : hideTopHand()
            }
        }
    }
}
