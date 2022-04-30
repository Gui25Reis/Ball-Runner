/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import SpriteKit


class GameView: CustumView {
    private var gameScene: SKView = {
        let v = SKView()
        v.layer.cornerRadius = 20
        v.layer.masksToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private var timeLabel: UILabel = CustumView.newLabel(sizeFont: 40, weight: .semibold)
    private var pauseButton: UIButton = CustumView.newButton(for: .pause)
    
    
    override init() {
        super.init()
        
        self.addSubview(self.gameScene)
        self.addSubview(self.pauseButton)
        self.addSubview(self.timeLabel)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    /* MARK: - Encapsulamento */
    
    public func setPauseAction(target: UIViewController, action: Selector) -> Void {
        self.pauseButton.addTarget(target, action: action, for: .touchDown)
    }
    
    public func setScore(with score: Int) -> Void { self.timeLabel.text = "\(score)" }
    
    public func setScene(scene: SKScene) -> Void { self.gameScene.presentScene(scene) }
    
    public func getScene() -> SKScene? {
        return self.gameScene.scene
    }
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        self.frame = (self.superview?.bounds)!
        
        let space: CGFloat = 15
        
        NSLayoutConstraint.activate([
            self.timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            self.timeLabel.widthAnchor.constraint(equalToConstant: 100),
            
            
            self.pauseButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: space-5),
            self.pauseButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            
            
            self.gameScene.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: space),
            self.gameScene.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -space),
            self.gameScene.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -space-3),
            self.gameScene.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: space-3)
        ])
    }
    
    
    /* MARK: - Outros */
    
    public func showInformations(is_: Bool) -> Void {
        self.gameScene.showsFPS = is_           // Mostra o fps
        self.gameScene.showsNodeCount = is_     // Mostra a quantidade de nodes que tem
    }
}
