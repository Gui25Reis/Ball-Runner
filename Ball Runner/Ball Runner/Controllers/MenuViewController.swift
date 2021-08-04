//
//  MenuViewController.swift
//  Ball Runner
//
//  Created by Gui Reis on 30/07/21.
//

import UIKit
import GameKit

class MenuViewController: UIViewController{
    let myView:MenuView = MenuView()
    let gameCenter = ManegerGameCenter()
    var clicked:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.myView.setTitleLabel(text: "Ball Runner")
        self.myView.setScoreLabel(text: String(UserDefaults.standard.integer(forKey: "score")))

        
        self.myView.getTutorialButton().addTarget(self, action: #selector(self.tutorialAction), for: .touchDown)
        
        self.myView.getPlayButton().addTarget(self, action: #selector(self.playAction), for: .touchDown)
        
        self.myView.getLeaderboardButton().addTarget(self, action: #selector(self.leaderboardAction), for: .touchDown)
        
        self.myView.getAchievmentsButton().addTarget(self, action: #selector(self.achievementsAction), for: .touchDown)
    
        self.view = self.myView
        

        self.gameCenter.authenticateUser(from: self)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.myView.setWarningLabel(text: "")
    }
    
    
    override func didMove(toParent parent: UIViewController?) {
        self.gameCenter.showAvatarGameCenter(isVisible: true)
    }
    
    
    /* MARK: Ações do botões */
    
    @objc func tutorialAction() {
        let vc = TutorialViewController()
        vc.modalTransitionStyle = .coverVertical

        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func playAction() {
        let vc = GameViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve

        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func leaderboardAction() {
        if (!self.gameCenter.toSpecificPage(from: self, to: .leaderboards)) {
            self.showWarningLabel()
        }
    }
    
    @objc func achievementsAction() {
        if (!self.gameCenter.toSpecificPage(from: self, to: .achievements)) {
            self.showWarningLabel()
        }
    }
    
    func showWarningLabel() {
        self.myView.setWarningLabel(text: "Game center not connected.")
    }
}


