/* Gui Reis    -    gui.sreis25@gmail.com */


enum Colors: CustomStringConvertible {
    // UI
    case background
    case text
    case button
    case game
    
    // Particle
    case enemy
    case player
    case power
    
    var description: String {
        switch self {
        case .background:
            return "Background"
        case .text, .button, .power:
            return "Button"
        case .game:
            return "Game"
        case .enemy:
            return "Enemy"
        case .player:
            return "Player"
        }
    }
}
