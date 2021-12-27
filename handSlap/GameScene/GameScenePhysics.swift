import SpriteKit

extension GameScene {
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("contact")
        handContact = true
        
        // был удар снизу (sideAttack - переключается после удара на touchesBegan)
        if gameVC.game.sideAttack == .topHandAttack {
            gameVC.game.pointTopHand += 1
        } else {
            gameVC.game.pointBottomHand += 1
        }
        gameVC.shake()
        gameVC.updateGame()
        unlockAllHand()
    }
    
    ///
    func checkContact() {
        print("checkContact")
        /// если был контакт - атака остаётся с прежней стороны
        /// если контакта не было - меняется на противоположную
        if self.handContact == true {
            gameVC.game.sideAttack = gameVC.game.sideAttack == .bottomHandAttack ? .bottomHandAttack : .topHandAttack
            self.handContact = false
        } else {
            gameVC.game.sideAttack = gameVC.game.sideAttack == .bottomHandAttack ? .topHandAttack : .bottomHandAttack
            gameVC.showAllIndicatorsFalseStart()
        }
    }
}
