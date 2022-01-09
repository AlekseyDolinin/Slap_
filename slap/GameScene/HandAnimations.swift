import SpriteKit

extension GameScene {
    //
    func slapTopHand() {
        if topHandIsMoving == true {return}
        topHandIsMoving = true
        topHand.zPosition = 1
        topHand.run(blockSlapTop) {
            self.topHandIsMoving = false
            self.checkContact()
            self.topHand.zPosition = 0
            self.gameVC.updateGame()
        }
    }
    
    //
    func slapBottomHand() {
        if bottomHandIsMoving == true {return}
        bottomHandIsMoving = true
        bottomHand.zPosition = 1
        bottomHand.run(blockSlapBottom) {
            self.bottomHandIsMoving = false
            self.checkContact()
            self.bottomHand.zPosition = 0
            self.gameVC.updateGame()
        }
    }
    
    //
    func hideTopHand() {
        if topHandIsMoving == true {return}
        topHandIsMoving = true
        if bottomHandIsMoving == false {
            gameVC.updateFalseStartCount()
        }
        topHand.run(blockHideTop) {
            self.topHandIsMoving = false
        }
    }
    
    //
    func hideBottomHand() {
        if bottomHandIsMoving == true {return}
        bottomHandIsMoving = true
        if topHandIsMoving == false {
            gameVC.updateFalseStartCount()
        }
        bottomHand.run(blockHideBottom) {
            self.bottomHandIsMoving = false
        }
    }
}
