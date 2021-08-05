/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class EndgameViewController: UIViewController {
    private let myView:EndgameView = EndgameView()
    private var parentVC: UIViewController!
    private var score:Int!
    
    
    init(parentVC:UIViewController, score:Int) {
        super.init(nibName: nil, bundle: nil)
        self.score = score
        self.parentVC = parentVC
        
        // ManegerGameCenter.showAvatarGameCenter(isVisible: true)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    /* MARK: Ciclos de Vida */
    
    public override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        let texts:[String] = ["Game Over".localized(), "Score".localized(), "Best".localized()]
        self.myView.setTitleLabels(list: texts)
                
        let defaults = UserDefaults.standard
        
        if (self.score > defaults.integer(forKey: "score")) {
            ManegerGameCenter.setHighScore(score: self.score)
            defaults.set(self.score, forKey: "score")
        }
        
        self.myView.setBestLabel(text: String(defaults.integer(forKey: "score")))
        self.myView.setScoreLabel(text: String(self.score))
        
        self.myView.getRestartButton().addTarget(self, action: #selector(self.restartAction), for: .touchDown)
        
        self.myView.getShareButton().addTarget(self, action: #selector(self.shareAction), for: .touchDown)
        self.view = self.myView
    }
    

    /* MARK: Ações do botões */
    
    @objc func restartAction() -> Void {
        self.dismiss(animated: false, completion: nil)
        self.parentVC.dismiss(animated: false, completion: nil)
    }
    
    @objc func shareAction() -> Void {
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
