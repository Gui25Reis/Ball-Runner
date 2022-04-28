/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class TutorialViewController: UIViewController {
    
    /* MARK: - Ciclos de Vida */
    
    public override func loadView() -> Void {
        super.loadView()
        
        let myView = TutorialView()
        self.view = myView
    }
    
    public override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        guard let view = self.view as? TutorialView else {return}
        
        view.setTitleText(with: "Tutorial".localized())
        
        let subtitlesTexts: [String] = [
            "Objective".localized(), "Controls".localized(), "Specials".localized()
        ]
        
        let descriptionTexts: [String] = [
            "Don't let the red balls catch you!! Survive as long as you can.".localized(),
            "Swipe on any place at the screen to control your ball, the blue one.".localized(),
            "You have powers!! Catch them when appers on the screen.".localized()
        ]
        
        view.setTexts(subtitle: subtitlesTexts, description: descriptionTexts)
        
        view.setExitAction(target: self, action: #selector(self.exitAction))
    }
    
    
    /* MARK: - Ação do botão */
    
    @objc func exitAction() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
}
