//
//  TutorialViewController.swift
//  Ball Runner
//
//  Created by Gui Reis on 22/07/21.
//

import UIKit

class TutorialViewController: UIViewController {
    let myView:TutorialView = TutorialView()
    let gameCenter = ManegerGameCenter()
    
    let subtitlesTexts:[String] = ["Objective", "Controls", "Specials"]
    let descriptionTexts:[String] = [
        "Don't let the red balls catch you!! Survive as long as you can.",
        "Swipe on any place at the screen to control your ball, the blue one.",
        "You have powers!! Catch them when appers on the screen."
    ]
    
    let duration:TimeInterval = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myView.setTitleLabel(text: "Tutorial")
        self.myView.setDescriptionLabels(list: descriptionTexts)
        self.myView.setSubTitleLabels(list: subtitlesTexts)
        
        self.myView.getExitButton().addTarget(self, action: #selector(self.exitAction), for: .touchDown)
        
        self.view = self.myView
        
        self.myView.getObjectsToAnimate()[1][0].center.x += 150
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.gameCenter.showAvatarGameCenter(isVisible: false)
    }
    
    @objc func exitAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
