/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class Buttons {
    private static func getButtun(icon:String, _ isIcon:Bool = true, _ sizeFont:CGFloat = 30, _ corner:CGFloat = 50) -> UIButton {
        let bt = UIButton()
        
        if (isIcon) {self.setBtIcon(bt: bt, icon: icon, sizeFont)}
        else {
            let img = UIImage(named: icon)?.withRenderingMode(.alwaysTemplate)
            bt.setImage(img, for: .normal)
        }
        
        //bt.layer.cornerRadius = corner/2
        bt.tintColor = #colorLiteral(red: 1, green: 0.9845215678, blue: 0.9319496751, alpha: 1)
        bt.backgroundColor = #colorLiteral(red: 0, green: 0.1340581775, blue: 0.22262308, alpha: 1)
        
        // Constraints
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.widthAnchor.constraint(equalToConstant: corner).isActive = true
        bt.heightAnchor.constraint(equalToConstant: corner).isActive = true
        return bt
    }
    
    public static func setBtIcon(bt:UIButton, icon:String, _ sizeFont:CGFloat = 25) -> Void {
        let configIcon = UIImage.SymbolConfiguration(pointSize: sizeFont, weight: .bold, scale: .large)
        bt.setImage(UIImage(systemName: icon, withConfiguration: configIcon), for: .normal)
    }
    
    
    /* MARK: - SFSymbols */
    
    public static func getHomeButton() -> UIButton {
        return self.getButtun(icon: "house.circle.fill")
    }
    
    public static func getPauseButton() -> UIButton {
        return self.getButtun(icon: "pause.circle.fill")
    }
    
    public static func getTutorialButton() -> UIButton {
        return self.getButtun(icon: "questionmark.circle.fill")
    }
    
    public static func getBackButton() -> UIButton {
        return self.getButtun(icon: "arrow.uturn.left.circle.fill")
    }
    
    public static func getExitButton() -> UIButton {
        return self.getButtun(icon: "xmark.circle.fill")
    }
    
    public static func getRestartButton() -> UIButton {
        return self.getButtun(icon: "arrow.counterclockwise.circle.fill", true, 80, 80)
    }
    
    public static func getPlayButton(_ size: CGFloat = 80) -> UIButton {
        return self.getButtun(icon: "play.circle.fill", true, size, size)
    }
    
    
    /* MARK: - Assets */
    
    public static func getShareButton() -> UIButton {
        return self.getButtun(icon: "ShareButton", false, 25, 40)
    }
    
    public static func getAchievmentButton() -> UIButton {
        return self.getButtun(icon: "AchievmentButton", false, 25, 40)
    }
    
    public static func getLeaderboardButton() -> UIButton {
        return self.getButtun(icon: "LeaderboardButton", false, 25, 40)
    }
}
