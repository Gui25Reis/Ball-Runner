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
    var bestScore:Int = 0
        
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    public func authenticateUser(from:UIViewController) ->Void{
        self.localUser.authenticateHandler = { vc, error in
            let isGameCenterReady = (vc == nil) && (error == nil)
            
            if isGameCenterReady {
                self.showAvatarGameCenter(isVisible: true)
                self.getHighScoreFromLeadboard()
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
    
    public func getHighScoreFromLeadboard() ->Void{
        if (self.localUser.isAuthenticated) {
            GKLeaderboard.loadLeaderboards(IDs: ["lbHighScore"]) { leaderboards, _ in
                leaderboards?[0].loadEntries(for: [self.localUser], timeScope: .allTime) { player, _, _ in
                    UserDefaults.standard.set(player?.score, forKey: "score")
                }
            }
        }
    }
    
    private func setLocalHighScore(name:String, score:Int) ->Void{
        if (self.localUser.displayName == name) {self.bestScore = score}
    }
    
    public func getHighScore() ->Int {
        print("Best", self.bestScore)
        return self.bestScore
        
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


//                    .loadEntries(for: .friendsOnly, timeScope: .allTime, range: NSRange(location: 1, length: (leaderboards?.count)!) ) {
//                    playerEntry, _, _, _ in
//                    print((playerEntry?.score)! as Any)
//                    UserDefaults.standard.set(playerEntry?.score, forKey: "score")
//                    if let entries = entries {
//                        let _ = entries.map { entry in
//                            print(entry.player.displayName)
//                            print(self.localUser.displayName)
//                            print(entry.player.displayName == self.localUser.displayName)
//                            if entry.player.displayName == self.localUser.displayName {
//                                print("Entre na condição")
//                                self.bestScore = entry.score
//                                UserDefaults.standard.set(entry.score, forKey: "score")
//                                print(self.bestScore)
//                                return
//                            }
//                        }
//                    }
