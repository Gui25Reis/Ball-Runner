/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import SpriteKit


class GameView: UIView {
    private var pauseButton: UIButton = Buttons().getPauseButton()
    
    private var gameScene: SKView = {
        let v = SKView()
        v.layer.cornerRadius = 20
        v.layer.masksToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private var timeLabel:UILabel = EndgameView.newLabel(sizeFont: 40, w: .semibold)
    
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = #colorLiteral(red: 0, green: 0.1340581775, blue: 0.22262308, alpha: 1)
        
        self.addSubview(self.gameScene)
        self.addSubview(self.pauseButton)
        self.addSubview(self.timeLabel)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    
    /* MARK: Encapsulamento */
    
    public func getPauseButton() -> UIButton { return self.pauseButton }
    
    public func setTimeLabel(text: String) -> Void { self.timeLabel.text = text }
    
    public func setScene(scene: SKScene) -> Void { self.gameScene.presentScene(scene) }
    
    
    /* MARK: Cicloe de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        self.frame = (self.superview?.bounds)!
        
        let space: CGFloat = 15
        
        self.timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant:40).isActive = true
        self.timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        self.pauseButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: space-5).isActive = true
        self.pauseButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        
        
        self.gameScene.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: space).isActive = true
        self.gameScene.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -space).isActive = true
        self.gameScene.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -space-3).isActive = true
        self.gameScene.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: space-3).isActive = true
    }
    
    
    /* MARK: Outros */
    
    public func showInformations(is_: Bool) -> Void {
        self.gameScene.showsFPS = is_           // Mostra o fps
        self.gameScene.showsNodeCount = is_     // Mostra a quantidade de nodes que tem
    }
}
