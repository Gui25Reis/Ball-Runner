//
//  ManagerGameCenter.swift
//  Ball Runner
//
//  Created by Gui Reis on 04/08/21.
//

import UIKit
import GameKit

class ManegerGameCenter: GKGameCenterViewController, GKGameCenterControllerDelegate {
    let localUser = GKLocalPlayer.local
        
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    public func authenticateUser(from:UIViewController) ->Void{
        self.localUser.authenticateHandler = { vc, error in
            let isGameCenterReady = (vc == nil) && (error == nil)
            
            if isGameCenterReady {
                self.showAvatarGameCenter(isVisible: true)
                return
            }
            guard error == nil else { return }
            from.present(vc!, animated: true, completion: nil)
        }
    }
    
    
    public func setHighScore(score:Int) ->Void {
        if (self.localUser.isAuthenticated) {
            GKLeaderboard.submitScore(score, context: 0, player: self.localUser, leaderboardIDs: ["lbHighScore"], completionHandler: {error in} )
        }
    }
    
    public func getHighScore() ->Int{
        if (self.localUser.isAuthenticated) {
            return 1
        }
        return 0
    }
    
    public func toSpecificPage(from:UIViewController, to:GKGameCenterViewControllerState) ->Bool{
        if (self.localUser.isAuthenticated) {
            let vc = GKGameCenterViewController(state: to)
            vc.gameCenterDelegate = self
            from.present(vc, animated: true, completion: nil)
            return true
        }; return false
    }
    
    public func showAvatarGameCenter(isVisible:Bool) ->Void{
        if (self.localUser.isAuthenticated) {
            let avatar = GKAccessPoint.shared
            avatar.location = .topLeading
            avatar.isActive = isVisible
        }
    }
}
