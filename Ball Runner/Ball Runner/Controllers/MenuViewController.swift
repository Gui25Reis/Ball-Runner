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
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.myView.setTitleLabel(text: "Ball Runner")
        self.myView.setScoreLabel(text: String(UserDefaults.standard.integer(forKey: "score")))

        
        self.myView.getTutorialButton().addTarget(self, action: #selector(self.tutorialAction), for: .touchDown)
        
        self.myView.getPlayButton().addTarget(self, action: #selector(self.playAction), for: .touchDown)
        
        self.myView.getLeaderboardButton().addTarget(self, action: #selector(self.leaderboardAction), for: .touchDown)
        
        self.myView.getAchievmentsButton().addTarget(self, action: #selector(self.achievementsAction), for: .touchDown)
        
        self.view = self.myView
    
        
        self.present(MenagerGameCenter(state: .dashboard), animated: false, completion: nil)
        MenagerGameCenter.showAvatarGameCenter(isVisible: true)
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
        self.present(MenagerGameCenter(state: .leaderboards), animated: false, completion: nil)
//        let vc = GKGameCenterViewController(state: .leaderboards)
//        //vc.gameCenterDelegate = self
//        present(vc, animated: true, completion: nil)
    }
    
    @objc func achievementsAction() {
        self.present(MenagerGameCenter(state: .achievements), animated: false, completion: nil)
//        let vc = GKGameCenterViewController(state: .achievements)
//        //vc.gameCenterDelegate = self
//        present(vc, animated: true, completion: nil)
    }
}


