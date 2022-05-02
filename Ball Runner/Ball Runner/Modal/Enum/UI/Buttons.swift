/* Gui Reis    -    gui.sreis25@gmail.com */


enum Button: CustomStringConvertible {
    case home
    case pause
    case tutorial
    case back
    case exit
    case restart
    case play
    case share
    case achievments
    case leaderboard
    
    var description: String {
        switch self {
        case .home:
            return "house.circle.fill"
        case .pause:
            return "pause.circle.fill"
        case .tutorial:
            return "questionmark.circle.fill"
        case .back:
            return "arrow.uturn.left.circle.fill"
        case .exit:
            return "xmark.circle.fill"
        case .restart:
            return "arrow.counterclockwise.circle.fill"
        case .play:
            return "play.circle.fill"
        case .share:
            return "ShareButton"
        case .achievments:
            return "AchievmentButton"
        case .leaderboard:
            return "LeaderboardButton"
        }
    }
}
