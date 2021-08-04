//
//  ManagerGameCenter.swift
//  Ball Runner
//
//  Created by Gui Reis on 04/08/21.
//

import UIKit
import GameKit

class MenagerGameCenter: UIViewController, GKGameCenterControllerDelegate {
    let localUser = GKLocalPlayer.local
    
    init(state:GKGameCenterViewControllerState) {
        super.init(nibName: nil, bundle: nil)
                
        if (state != .dashboard) {self.toSpecificPage(to: state)}
        else {
            self.authenticateUser()
        }
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    public func authenticateUser() ->Void {
        self.localUser.authenticateHandler = { vc, error in
            let isGameCenterReady = (vc == nil) && (error == nil)
            
            if isGameCenterReady {
                MenagerGameCenter.showAvatarGameCenter(isVisible: true)
                return
            }
            
            guard error == nil else { return }
            
            self.present(vc!, animated: true, completion: nil)
            
        }
    }
    
    
    public func setHighScore(score:Int) ->Void {
        GKLeaderboard.submitScore(score, context: 0, player: self.localUser, leaderboardIDs: ["lbHighScore"], completionHandler: {error in} )
    }
    
    public func toSpecificPage(to: GKGameCenterViewControllerState) {
        if (self.localUser.isAuthenticated) {
            let vc = GKGameCenterViewController(state: to)
            vc.gameCenterDelegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    static func showAvatarGameCenter(isVisible:Bool) ->Void{
        if (GKLocalPlayer.local.isAuthenticated) {
            let avatar = GKAccessPoint.shared
            avatar.location = .topLeading
            avatar.isActive = isVisible
        }
    }
    
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
        self.dismiss(animated: false, completion: nil)
    }
}
