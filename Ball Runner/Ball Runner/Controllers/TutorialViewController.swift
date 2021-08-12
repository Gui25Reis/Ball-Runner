//
//  TutorialViewController.swift
//  Ball Runner
//
//  Created by Gui Reis on 22/07/21.
//

import UIKit

class TutorialViewController: UIViewController {
    private let myView = TutorialView()
    private var willPresent:Bool!
    private let duration:TimeInterval = 2
    
    private let subtitlesTexts:[String] = [
        "Objective".localized(), "Controls".localized(), "Specials".localized()
    ]
    private let descriptionTexts:[String] = [
        "Don't let the red balls catch you!! Survive as long as you can.".localized(),
        "Swipe on any place at the screen to control your ball, the blue one.".localized(),
        "You have powers!! Catch them when appers on the screen.".localized()
    ]
    
    
    init(from:UIViewController) {
        super.init(nibName: nil, bundle: nil)
        
        if (from === MenuViewController.self) {self.willPresent = true}
        else {self.willPresent = false}
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    /* MARK: Ciclos de Vida */
    
    public override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        self.myView.setTitleLabel(text: "Tutorial".localized())
        self.myView.setDescriptionLabels(list: descriptionTexts)
        self.myView.setSubTitleLabels(list: subtitlesTexts)
        
        self.myView.getExitButton().addTarget(self, action: #selector(self.exitAction), for: .touchDown)
        
        self.view = self.myView
        
        self.myView.getObjectsToAnimate()[1][0].center.x += 150
    }
    
    public override func viewWillAppear(_ animated: Bool) -> Void {
        super.viewWillAppear(animated)
        ManegerGameCenter.showAvatarGameCenter(isVisible: false)
    }
    
    
    /* MARK: Ação do botão */
    
    @objc func exitAction() -> Void {
        if (self.willPresent) {ManegerGameCenter.showAvatarGameCenter(isVisible: true)}
        self.dismiss(animated: true, completion: nil)
    }
}
