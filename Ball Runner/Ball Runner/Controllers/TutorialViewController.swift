/* Gui Reis    -    gui.sreis25@gmail.com */

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
        
        view.setTutorialTopics(with: [
            TutorialTopic(for: "Objective"),
            TutorialTopic(for: "Controls"),
            TutorialTopic(for: "Specials")
        ])
        
        view.setExitAction(target: self, action: #selector(self.exitAction))
    }
    
    
    /* MARK: - Ação do botão */
    
    @objc func exitAction() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
}
