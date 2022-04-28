/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class MenuViewController: UIViewController {
    
    /* MARK: - Ciclos de Vida */
    
    public override func loadView() -> Void {
        super.loadView()
        
        let myView = MenuView()
        self.view = myView
    }
    
    
    public override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        guard let view = self.view as? MenuView else {return}

        view.setTitleText(with: "Ball Runner")
        
        // Definindo as ações dos botões
        view.setTutorialAction(target: self, action: #selector(self.tutorialAction))
        view.setPlayAction(target: self, action: #selector(self.playAction))
        view.setLeaderboardAction(target: self, action: #selector(self.leaderboardAction))
        view.setAchievmentsAction(target: self, action: #selector(self.achievementsAction))
        
        self.gameCenterAutentication()
    }
    
    
    /* MARK: - Ações do botões */
    
    @objc func tutorialAction() -> Void {
        let vc = TutorialViewController()
        vc.modalTransitionStyle = .coverVertical
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func playAction() -> Void {
        let vc = GameViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve

        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func leaderboardAction() -> Void {
        if let vc = GameCenterService.shared.showGameCenterPage(.leaderboards) {
            self.present(vc, animated: true)
        }
    }
    
    @objc func achievementsAction() -> Void {
        if let vc = GameCenterService.shared.showGameCenterPage(.achievements) {
            self.present(vc, animated: true)
        }
    }
    
    
    /* MARK: - Outros */
    
    /// Fazendo a autenticação com o Game Center
    func gameCenterAutentication() {
        guard let view = self.view as? MenuView else {return}
        
        view.setScore(with: UserDefaults.getIntValue(with: .highScore))
        
        GameCenterService.shared.autenticateUser {vc, score, error in
            if error != nil {
                view.setWarningText(with: error?.description ?? "Erro")
                return
            }
            
            if let vc = vc {
                self.present(vc, animated: true)
                return
            }
            
            if let score = score {
                view.setScore(with: score)
                view.setWarningText(with: "")
            }
        }
    }
}
