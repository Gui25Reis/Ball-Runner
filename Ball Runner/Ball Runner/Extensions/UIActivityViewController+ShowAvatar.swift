//
//  GKGameCenterControllerDelegate+DidFinished.swift
//  Ball Runner
//
//  Created by Gui Reis on 04/08/21.
//

//import class GameKit.GKGameCenterViewController
//import protocol GameKit.GKGameCenterControllerDelegate

import GameKit

extension UIActivityViewController {
    open override func viewWillAppear(_ animated: Bool) {
        ManegerGameCenter().showAvatarGameCenter(isVisible: false)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        ManegerGameCenter().showAvatarGameCenter(isVisible: true)
    }
}
