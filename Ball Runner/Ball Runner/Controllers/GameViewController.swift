/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import SpriteKit


class GameViewController: UIViewController {
    
    /* MARK: - Atributos */
    
    private let scene = GameScene()
    private lazy var pauseView = PauseView()
    private lazy var gamePause: Bool = false
    private lazy var timer: Int = 0
    private var countdown: Timer!
    private var timeWhenPaused = Date()
    
    // Barra embaixo de saída do app: puxa duas vezes pra sair
    public override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return UIRectEdge.bottom
    }
    
    
    /* MARK: - Ciclos de Vida */
    
    public override func loadView() {
        super.loadView()
        
        let myView = GameView()
        myView.setScene(scene: self.scene)
        
        self.view = myView
    }
    
    
    public override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        guard let view = self.view as? GameView else {return}
        
        view.showInformations(is_: false)
        view.setScore(with: 0)
        view.setPauseAction(target: self, action: #selector(self.pauseAction))
        
        
        // PauseView
        self.pauseView.setTitleText(with: "Pause")
        
        self.pauseView.setPlayAction(target: self, action: #selector(self.playAction))
        
        self.pauseView.setTutorialAction(target: self, action: #selector(self.tutorialAction))
        
        self.pauseView.setHomeAction(target: self, action: #selector(self.homeAction))
        
        self.pauseView.setAchievmentsAction(target: self, action: #selector(self.achievementsAction))
        
        
        // Timer
        self.countdown = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
        self.setupBackgroundState()
    }
    
    /// Quando entra no app (sai do segundo plano)
    @objc func didLeaveFromBackgound() {
        let dateNow = Date()
        let diference = Calendar.current.dateComponents([.second], from: self.timeWhenPaused, to: dateNow)
        
        if let seconds = diference.second {
            if seconds > 20 {
                self.endgameAction()
                return
            }
        }
        self.gamePause = true
    }
    
    /// Quando sai do app (entra em segundo plano)
    @objc func didEnterOnBackground() {
        self.timeWhenPaused = Date()
        self.pauseAction()
    }
    
    
    /* MARK: - Drag & Drop */
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        if let touch = touches.first {
            let location = touch.location(in: self.scene)
            self.scene.startDrag(at: location)
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        if let touch = touches.first {
            let location = touch.location(in: self.scene)
            self.scene.drag(at: location)
        }
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        self.scene.drop()
    }
    
    
    /* MARK: - Ações dos botões */
    
    /* View: Game */
    @objc func pauseAction() -> Void {
        self.gamePause = true
        self.scene.setStatuGame(to: false)
        self.view.addSubview(self.pauseView)
    }
    
    @objc func updateTimer() -> Void {
        if (self.scene.isGameOver()){
            self.countdown.invalidate()
            self.addView()
            self.endgameAction()
        }
        else if (!self.scene.isGameStart() && !self.gamePause){
            guard let view = self.view as? GameView else {return}
            
            self.timer += 1
            view.setScore(with: self.timer)
            self.scene.updadePerSecond(gameTime: self.timer)
        }
    }
    
    @objc func endgameAction() -> Void {
        let vc = EndgameViewController(parentVC: self, score: self.timer)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
    
        self.present(vc, animated: true)
    }
    
    
    /* View: Pause */
    @objc func playAction() -> Void {
        self.pauseView.setWarningText(with: "")
        self.pauseView.removeFromSuperview()
        if (timer != 0) {
            self.scene.setStatuGame(to: true)
        }
        self.gamePause = false
    }
    
    @objc func tutorialAction() -> Void {
        let vc = TutorialViewController()
        vc.modalTransitionStyle = .coverVertical
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func homeAction() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func achievementsAction() -> Void {
        if let vc = GameCenterService.shared.showGameCenterPage(.achievements) {
            self.present(vc, animated: true)
        }
    }
    
    
    /* MARK: - Outros */
    
    private func addView() -> Void {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0, green: 0.1340581775, blue: 0.22262308, alpha: 1)
        self.view.addSubview(v)
        v.frame = self.view.bounds
    }
    
    /// Configura o que acontece quando o app entre em segundo plano
    private func setupBackgroundState() -> Void {
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.didLeaveFromBackgound),
            name: UIApplication.didBecomeActiveNotification, object: nil
        )
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.didEnterOnBackground),
            name: UIApplication.willResignActiveNotification, object: nil
        )
    }
}
