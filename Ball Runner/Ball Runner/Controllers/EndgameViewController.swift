//
//  EndgameViewController.swift
//  Ball Runner
//
//  Created by Gui Reis on 30/07/21.
//

import UIKit

class EndgameViewController: UIViewController {
    let myView:EndgameView = EndgameView()
    var score:Int!
    
    init(score:Int) {
        super.init(nibName: nil, bundle: nil)
        
        MenagerGameCenter.showAvatarGameCenter(isVisible: true)
        
        self.score = score
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myView.setTitleLabels(list: ["Game Over", "Score", "Best"])
        
        let defaults = UserDefaults.standard
        
        if (self.score > defaults.integer(forKey: "score")) {
            let vc = MenagerGameCenter(state: .dashboard)
            vc.setHighScore(score: self.score)
            defaults.set(self.score, forKey: "score")
        }
        
        self.myView.setBestLabel(text: String(defaults.integer(forKey: "score")))
        self.myView.setScoreLabel(text: String(self.score))
        
        self.myView.getRestartButton().addTarget(self, action: #selector(self.restartAction), for: .touchDown)
        
        self.myView.getShareButton().addTarget(self, action: #selector(self.shareAction), for: .touchDown)
        self.view = self.myView
    }
    
    
    /* MARK: Ações do botões */
    
    @objc func restartAction() {
        let vc = MenuViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func shareAction() {
        // Cria o print
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)     // Salva no camera roll
        
        // Chama o botão de compartilhar
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem     // Ipad
        present(vc, animated: true)
    }
    
    
}
