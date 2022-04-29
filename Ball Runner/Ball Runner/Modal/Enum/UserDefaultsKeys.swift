/* Gui Reis     -    gui.sreis25@gmail.com */

enum UserDefaultsKeys: CustomStringConvertible {
    case highScore
    case warning
    
    var description: String {
        switch self {
        case .highScore: return "highscore"
        case .warning: return "warning"
        }
    }
}
