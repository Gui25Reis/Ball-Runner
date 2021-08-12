/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import GameKit


class ManegerGameCenter: GKGameCenterViewController, GKGameCenterControllerDelegate {
    static func authenticateUser(from:UIViewController, label:UILabel) -> Void {
        GKLocalPlayer.local.authenticateHandler = { vc, error in
            if (vc == nil && error == nil) {
                self.showAvatarGameCenter(isVisible: true)
                self.getHighScoreFromLeadboard(label:label)
                return
            }
            guard error == nil else { return }
            
            from.present(vc!, animated: true, completion: nil)
        }
    }
    
    static func showAvatarGameCenter(isVisible:Bool) -> Void {
        if (GKLocalPlayer.local.isAuthenticated) {
            GKAccessPoint.shared.location = .topLeading
            GKAccessPoint.shared.showHighlights = false
            GKAccessPoint.shared.isActive = isVisible
        }
    }
    
    static func setHighScore(score:Int) -> Void {
        if (GKLocalPlayer.local.isAuthenticated) {
            GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: ["lbHighScore"], completionHandler: {error in} )
        }
    }
    
    static func getHighScoreFromLeadboard(label:UILabel) -> Void {
        if (GKLocalPlayer.local.isAuthenticated) {
            GKLeaderboard.loadLeaderboards(IDs: ["lbHighScore"]) { leaderboards, _ in
                leaderboards?[0].loadEntries(for: [GKLocalPlayer.local], timeScope: .allTime) {
                    player, _, _ in
                    UserDefaults.standard.set(player?.score, forKey: "score")
                    label.text = "Best".localized() + " " + String(player!.score) // String(UserDefaults.standard.integer(forKey: "score"))
                }
            }
        }
    }
            
    public func toSpecificPage(from:UIViewController, to:GKGameCenterViewControllerState) -> Bool {
        if (GKLocalPlayer.local.isAuthenticated) {
            let vc = GKGameCenterViewController(state: to)
            vc.gameCenterDelegate = self
            from.present(vc, animated: true, completion: nil)
            return true
        }; return false
    }

    
    /* Delegate */

    public func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) -> Void {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
