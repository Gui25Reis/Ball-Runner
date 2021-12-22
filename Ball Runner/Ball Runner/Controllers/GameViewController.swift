/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import SpriteKit


class GameViewController: UIViewController{
    public override var preferredScreenEdgesDeferringSystemGestures:UIRectEdge {
        return UIRectEdge.bottom
    }       // Barra embaixo de saída do app: puxa duas vezes pra sair

    private var scene:GameScene!
    private lazy var gameView = GameView()
    private lazy var pauseView = PauseView()
    private lazy var gamePause:Bool = false
    private lazy var timer:Int = 0
    private var countdown:Timer!
    
    
    /* MARK: - Ciclos de Vida */
    
    public override func viewWillAppear(_ animated: Bool) -> Void {
        super.viewWillAppear(animated)
        
        ManegerGameCenter.showAvatarGameCenter(isVisible: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.pauseAction), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    public override func viewWillDisappear(_ animated: Bool) -> Void {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        
        // ManegerGameCenter.showAvatarGameCenter(isVisible: true)
    }
    
    public override func viewDidLayoutSubviews() -> Void {
        super.viewDidLayoutSubviews()
        self.view = self.gameView
    }
    

    public override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        // GameView
        self.scene = GameScene()
        self.gameView.setScene(scene: self.scene)
        
        self.gameView.showInformations(is_: false)
        
        self.gameView.setTimeLabel(text: "0")
        
        self.gameView.getPauseButton().addTarget(self, action: #selector(self.pauseAction), for: .touchDown)
        
        
        // PauseView
        self.pauseView.setTitleLabel(text: "Pause")
        
        self.pauseView.getPlayButton().addTarget(self, action: #selector(self.playAction), for: .touchDown)
        
        self.pauseView.getTutorialButton().addTarget(self, action: #selector(self.tutorialAction), for: .touchDown)
        
        self.pauseView.getHomeButton().addTarget(self, action: #selector(self.homeAction), for: .touchDown)
        
        self.pauseView.getAchievmentsButton().addTarget(self, action: #selector(self.achievementsAction), for: .touchDown)
        
        
        // Timer
        self.countdown = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    
    /* MARK: - Drag & Drop */
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        if let touch = touches.first {
            let location = touch.location(in: self.scene)
            self.scene.startDrag([location.x, location.y])
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        if let touch = touches.first {
            let location = touch.location(in: self.scene)
            self.scene.drag([location.x, location.y])
        }
    }
    

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        self.scene.drop()
    }
    
    
    /* MARK: - Ações dos botões */
    
    /* View: Game */
    @objc func pauseAction() -> Void {
        self.gamePause = true
        self.scene.setStatuGame(is_: false)
        self.view.addSubview(self.pauseView)
    }
    
    @objc func updateTimer() -> Void {
        if (self.scene.isGameOver()){
            self.countdown.invalidate()
            self.addView()
            self.endgameAction()
        }
        else if (!self.scene.isGameStart() && !self.gamePause){
            self.timer += 1
            self.gameView.setTimeLabel(text: String(self.timer))
            self.scene.updadePerSecond(gameTime: self.timer)
        }
    }
    
    @objc func endgameAction() -> Void {
        let vc = EndgameViewController(parentVC: self, score: self.timer)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve

        self.present(vc, animated: true, completion: nil)
    }
    
    
    /* View: Pause */
    @objc func playAction() -> Void {
        self.pauseView.setWarningLabel(text: "")
        self.pauseView.removeFromSuperview()
        if (timer != 0){self.scene.setStatuGame(is_: true)}
        self.gamePause = false
    }
    
    @objc func tutorialAction() -> Void {
        let vc = TutorialViewController(from: self)
        vc.modalTransitionStyle = .coverVertical
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func homeAction() -> Void {
        ManegerGameCenter.showAvatarGameCenter(isVisible: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func achievementsAction() -> Void {
        if (!ManegerGameCenter().toSpecificPage(from: self, to: .achievements)) {
            self.pauseView.setWarningLabel(text: "Game center not connected.".localized())
        }
    }
    
    
    /* MARK: - Outros */
    
    private func addView() -> Void {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0, green: 0.1340581775, blue: 0.22262308, alpha: 1)
        self.view.addSubview(v)
        v.frame = (v.superview?.bounds)!
    }
}
