/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import GameKit

class GameCenterDelegate: NSObject, GKGameCenterControllerDelegate {
    
    /* MARK: - Delegate */

    public func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) -> Void {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
