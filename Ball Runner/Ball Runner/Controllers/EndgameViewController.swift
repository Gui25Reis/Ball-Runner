/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class EndgameViewController: UIViewController {
    private var parentVC: UIViewController
    private var score: Int
    
    
    init(parentVC: UIViewController, score: Int) {
        self.score = score
        self.parentVC = parentVC

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    /* MARK: - Ciclos de Vida */
    
    public override func loadView() -> Void {
        super.loadView()
        
        let myView = EndgameView()
        self.view = myView
    }
    
    public override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        guard let view = self.view as? EndgameView else {return}
        
        let texts: [String] = ["Game Over".localized(), "Score".localized(), "Best".localized()]
        view.setTitleLabels(list: texts)
                
        view.setScore(with: self.score)
        
        view.setRestartAction(target: self, action: #selector(self.restartAction))
        view.setShareAction(target: self, action: #selector(self.shareAction))
        
        
        if self.score > UserDefaults.getIntValue(with: .highScore) {
            GameCenterService.shared.submitHighScore(score: self.score) {error in
                if let error = error {
                    view.setWarningText(with: error.localizedDescription)
                }
                
                view.setBestScore(with: UserDefaults.getIntValue(with: .highScore))
            }
        }
        
        view.setBestScore(with: UserDefaults.getIntValue(with: .highScore))
    }
    

    /* MARK: - Ações do botões */
    
    @objc func restartAction() -> Void {
        self.dismiss(animated: false, completion: nil)
        self.parentVC.dismiss(animated: false, completion: nil)
    }
    
    
    @objc func shareAction() -> Void {
        guard let view = self.view as? EndgameView else {return}
        
        view.setShareVisibility(for: false)         // Tira o botão de compartilhar
        
        // Cria o print
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Chama o botão de compartilhar
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem     // Ipad
        self.present(vc, animated: true)
        
        view.setShareVisibility(for: true)          // Volta o botão de compartilhar
    }
}
