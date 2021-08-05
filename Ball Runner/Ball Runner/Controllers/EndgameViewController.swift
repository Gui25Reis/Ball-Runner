//
//  EndgameViewController.swift
//  Ball Runner
//
//  Created by Gui Reis on 30/07/21.
//

import UIKit

class EndgameViewController: UIViewController {
    let myView:EndgameView = EndgameView()
    //let gameCenter = ManegerGameCenter()
    var score:Int!
    
    init(score:Int) {
        super.init(nibName: nil, bundle: nil)
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
            //self.gameCenter.setHighScore(score: self.score)
            defaults.set(self.score, forKey: "score")
        }
        
        self.myView.setBestLabel(text: String(defaults.integer(forKey: "score")))
        self.myView.setScoreLabel(text: String(self.score))
        
        self.myView.getRestartButton().addTarget(self, action: #selector(self.restartAction), for: .touchDown)
        
        self.myView.getShareButton().addTarget(self, action: #selector(self.shareAction), for: .touchDown)
        self.view = self.myView
    }
    

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.gameCenter.showAvatarGameCenter(isVisible: true)
//    }
    

    /* MARK: Ações do botões */
    
    @objc func restartAction() {
        let vc = MenuViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        //self.navigationController?.pushViewController(vc, animated: true)
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
        self.present(vc, animated: true)
    }
    
    
}
