import UIKit

class Game {
    
    var id: String
    var pointTopHand: Int
    var pointBottomHand: Int
    var falseStartCount: Int
    var sideAttack: SideAttack
    
    init(
        id: String,
        pointTopHand: Int = 0,
        pointBottomHand: Int = 0,
        falseStartCount: Int = 0,
        sideAttack: SideAttack
    ){
        self.id = id
        self.pointTopHand = pointTopHand
        self.pointBottomHand = pointBottomHand
        self.falseStartCount = falseStartCount
        self.sideAttack = sideAttack
        
    }
    
    enum SideAttack {
        case topHandAttack
        case bottomHandAttack
    }
}
