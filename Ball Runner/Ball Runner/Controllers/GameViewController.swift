/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
// Globais
import SpriteKit
import GameKit

class GameViewController: UIViewController{
    
    public override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return UIRectEdge.bottom
    }
    // Atributos da classe
    //private var gameCenter = ManegerGameCenter()
    private var scene = GameScene()
    private var gameView = GameView()
    private var pauseView = PauseView()
    private var gamePause:Bool = false
    
    private var timer:Int = 0
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.gameView.setScene(scene: self.scene)           // Mostra a cena criada
    }
    /**
        # Método [lifecycle]:
        Toda vez que a tela é carregada (inicializada) essas configuraçôes serão feitas.
    */
    public override func viewDidLoad() {
        super.viewDidLoad()                                 // Chama a função original
        
        //self.gameCenter.showAvatarGameCenter(isVisible: false)
        self.gameView.getPauseButton().addTarget(self, action: #selector(self.pauseAction), for: .touchDown)
        
        self.gameView.setTimeLabel(text: "0")
        
        self.gameView.showInformations(is_: true)
        
        
        self.pauseView.getPlayButton().addTarget(self, action: #selector(self.playAction), for: .touchDown)
        
        self.pauseView.getTutorialButton().addTarget(self, action: #selector(self.tutorialAction), for: .touchDown)
        
        self.pauseView.getHomeButton().addTarget(self, action: #selector(self.homeAction), for: .touchDown)
        
        self.pauseView.getAchievmentsButton().addTarget(self, action: #selector(self.achievementsAction), for: .touchDown)
        
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        self.view = self.gameView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.gameCenter.showAvatarGameCenter(isVisible: false)
    }
    
    /* MARK: Drag & Drop */
    
    /**
        # Método:
        Ação de quando clica na tela.
    */
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) ->Void{
        
        if let touch = touches.first {
            let location = touch.location(in: self.scene)        // Pega a localização atual do click
            self.scene.startDrag([location.x, location.y])
            
//            let touchesNodes = self.scene.nodes(at: location)    // Pega os nodes que foram clicados
//            for _ in touchesNodes {
//                self.scene.startDrag([location.x, location.y])   // Manda a localização pra cena
//            }
        }
    }
    
    
    /**
        # Método:
        Ação de quando arrasta algo na tela.
    */
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) ->Void{
        if let touch = touches.first {
            let location = touch.location(in: self.scene)        // Pega a localização
            self.scene.drag([location.x, location.y])            // Manda a localização pra cena
        }
    }
    
    /**
        # Método:
        Ação de quando para de clicar na tela.
    */
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) -> Void{
        self.scene.drop()
    }
    
//    override func didMove(toParent parent: UIViewController?) {
//        self.navigationController?.popViewController(animated: false)
//    }
    
    /* MARK: Ações dos botões */
    
    /* View: Game */
    @objc func pauseAction() -> Void{
        self.gamePause = true
        self.scene.setStatuGame(is_: false)
        self.pauseView.setTitleLabel(text: "Pause")
        self.view.addSubview(self.pauseView)
    }
    
    @objc func updateTimer() {
        if (self.scene.isGameOver()){self.endgameAction()}
        else if (!self.scene.isGameStart() && !self.gamePause){
            self.timer += 1
            self.gameView.setTimeLabel(text: String(self.timer))
            self.scene.updadePerSecond(gameTime: self.timer)
        }
    }
    
    @objc func endgameAction() -> Void{
        let vc = EndgameViewController(score: self.timer)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        //self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    
    
    /* View: Pause */
    @objc func playAction() -> Void{
        self.pauseView.removeFromSuperview()
        self.scene.setStatuGame(is_: true)
        self.gamePause = false
    }
    
    @objc func tutorialAction() {
        let vc = TutorialViewController()
        vc.modalTransitionStyle = .coverVertical
        
        self.navigationController?.pushViewController(vc, animated: true)
        //self.present(vc, animated: true, completion: nil)
    }
    
    @objc func homeAction() {
        //self.gameCenter.showAvatarGameCenter(isVisible: true)
        //self.navigationController?.popViewController(animated: false)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func achievementsAction() {
        
    }
}
