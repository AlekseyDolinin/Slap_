import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameVC: GameViewController!
    
    // Bit Mask
    var noneBitMask: UInt32 = 0x1 << 0
    var topHandBitMask: UInt32 = 0x1 << 1
    var bottomHandBitMask: UInt32 = 0x1 << 2
    //
    var topHand = SKSpriteNode()
    var bottomHand = SKSpriteNode()
    //
    var topHandIsMoving = false
    var bottomHandIsMoving = false
    //
    var handContact: Bool!
    //
    var durationAttackHand = 0.2
    var durationHideHand = 0.05
    //
    var slapTop = SKAction()
    var backSlapTop = SKAction()
    var blockSlapTop = SKAction.sequence([SKAction()])
    var hideTop = SKAction()
    var backHideTop = SKAction()
    var blockHideTop = SKAction.sequence([SKAction()])
    //
    var slapBottom = SKAction()
    var backSlapBottom = SKAction()
    var blockSlapBottom = SKAction.sequence([SKAction()])
    var hideBottom = SKAction()
    var backHideBottom = SKAction()
    var blockHideBottom = SKAction.sequence([SKAction()])
    //
    var pauseHand = SKAction.wait(forDuration: 0.05)
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        backgroundColor = .clear
        initVariables()
        createObject()
        createGame()
    }
    
    //
    func initVariables() {
        topHand = SKSpriteNode(imageNamed: "hand_\(gameVC.topHandIndex)")
        bottomHand = SKSpriteNode(imageNamed: "hand_\(gameVC.bottomHandIndex)")
        //
        slapTop = SKAction.move(by: CGVector(dx: 0, dy: -(size.height / 3)), duration: durationAttackHand)
        backSlapTop = SKAction.move(by: CGVector(dx: 0, dy: size.height / 3), duration: durationAttackHand)
        blockSlapTop = SKAction.sequence([slapTop, backSlapTop, pauseHand])
        hideTop = SKAction.move(by: CGVector(dx: 0, dy: size.height / 5), duration: durationHideHand)
        backHideTop = SKAction.move(by: CGVector(dx: 0, dy: -(size.height / 5)), duration: durationHideHand)
        blockHideTop = SKAction.sequence([hideTop, pauseHand, backHideTop])
        //
        slapBottom = SKAction.move(by: CGVector(dx: 0, dy: size.height / 3), duration: durationAttackHand)
        backSlapBottom = SKAction.move(by: CGVector(dx: 0, dy: -(size.height / 3)), duration: durationAttackHand)
        blockSlapBottom = SKAction.sequence([slapBottom, backSlapBottom, pauseHand])
        hideBottom = SKAction.move(by: CGVector(dx: 0, dy: -(size.height / 5)), duration: durationHideHand)
        backHideBottom = SKAction.move(by: CGVector(dx: 0, dy: size.height / 5), duration: durationHideHand)
        blockHideBottom = SKAction.sequence([hideBottom, pauseHand, backHideBottom])
    }
    
    //
    func createObject() {
        addChild(topHand)
        addChild(bottomHand)
    }
    
    //
    func createGame() {
        createBottomHand()
        createTopHand()
    }
    
    //
    func createTopHand() {
        topHand.name = "topHand"
        topHand.position = CGPoint(x: size.width / 2, y: size.height * 1.5)
        topHand.size = CGSize(width: size.width * 0.35, height: size.width * 1.4)
        topHand.yScale = -1
        topHand.xScale = -1
        topHand.zPosition = 0
        topHand.physicsBody = SKPhysicsBody(circleOfRadius: bottomHand.size.height / 2 - 20, center: CGPoint(x: 0, y: 0) )
        topHand.physicsBody?.isDynamic = true
        topHand.physicsBody?.affectedByGravity = false
        topHand.physicsBody?.categoryBitMask = topHandBitMask
        topHand.physicsBody?.contactTestBitMask = bottomHandBitMask
        topHand.physicsBody?.collisionBitMask = noneBitMask
        topHand.run(SKAction.moveTo(y: size.height, duration: 0.3))
    }
    
    //
    func createBottomHand() {
        bottomHand.name = "bottomHand"
        bottomHand.position = CGPoint(x: size.width / 2, y: -size.height / 2)
        bottomHand.size = CGSize(width: size.width * 0.35, height: size.width * 1.4)
        topHand.yScale = -1
        bottomHand.zPosition = 0
        bottomHand.physicsBody = SKPhysicsBody(circleOfRadius: bottomHand.size.height / 2 - 20, center: CGPoint(x: 0, y: 0) )
        bottomHand.physicsBody?.isDynamic = true
        bottomHand.physicsBody?.affectedByGravity = false
        bottomHand.physicsBody?.categoryBitMask = bottomHandBitMask
        bottomHand.physicsBody?.contactTestBitMask = topHandBitMask
        bottomHand.physicsBody?.collisionBitMask = noneBitMask
        bottomHand.run(SKAction.moveTo(y: 0, duration: 0.3))
    }
}
