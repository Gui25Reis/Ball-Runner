//
//  GameCenterDelegate.swift
//  Ball Runner
//
//  Created by Gui Reis on 24/04/22.
//

import GameKit

class GameCenterDelegate: NSObject, GKGameCenterControllerDelegate {
    
    /* MARK: - Delegate */

    public func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) -> Void {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
