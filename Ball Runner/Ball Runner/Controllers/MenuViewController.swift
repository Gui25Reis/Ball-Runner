/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class MenuViewController: UIViewController{
    private let myView:MenuView = MenuView()
    
    
    /* MARK: Ciclos de Vida */
    
    public override func viewDidLayoutSubviews() -> Void {
        super.viewDidLayoutSubviews()
        
        self.view = self.myView
    }
        
    public override func viewDidLoad() -> Void {
        super.viewDidLoad()
            
        self.myView.setTitleLabel(text: "Ball Runner")
        
        // Definindo as ações dos botões
        self.myView.getTutorialButton().addTarget(self, action: #selector(self.tutorialAction), for: .touchDown)
        
        self.myView.getPlayButton().addTarget(self, action: #selector(self.playAction), for: .touchDown)
        
        self.myView.getLeaderboardButton().addTarget(self, action: #selector(self.leaderboardAction), for: .touchDown)
        
        self.myView.getAchievmentsButton().addTarget(self, action: #selector(self.achievementsAction), for: .touchDown)
        
        // Autenticando com o Game Center
        ManegerGameCenter.authenticateUser(from: self)
    }
    
    
    public override func viewWillDisappear(_ animated: Bool) -> Void {
        super.viewWillDisappear(animated)
        
        self.myView.setWarningLabel(text: "")
    }
    
    
    public override func viewWillAppear(_ animated: Bool) -> Void {
        super.viewWillAppear(animated)
        
        let text = "Best".localized() + " " + String(UserDefaults.standard.integer(forKey: "score"))
        self.myView.setScoreLabel(text: text)
        
        ManegerGameCenter.showAvatarGameCenter(isVisible: true)
    }

    
    /* MARK: Ações do botões */
    
    @objc func tutorialAction() ->Void {
        let vc = TutorialViewController(from: self)
        vc.modalTransitionStyle = .coverVertical
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func playAction() -> Void {
        ManegerGameCenter.showAvatarGameCenter(isVisible: false)
        let vc = GameViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve

        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func leaderboardAction() -> Void {
        if (!ManegerGameCenter().toSpecificPage(from: self, to: .leaderboards)) {
            self.showWarningLabel()
        }
    }
    
    @objc func achievementsAction() -> Void {
        if (!ManegerGameCenter().toSpecificPage(from: self, to: .achievements)) {
            self.showWarningLabel()
        }
    }
    
    
    /* MARK: Outros */
    
    private func showWarningLabel() -> Void {
        self.myView.setWarningLabel(text: "Game center not connected.".localized())
    }
}
