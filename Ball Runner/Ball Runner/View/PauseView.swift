/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class PauseView: UIView {
    private let playButton:UIButton = Buttons.getPlayButton(60)
    private let homeButton:UIButton = Buttons.getHomeButton()
    private let achievmentsButton:UIButton = Buttons.getAchievmentButton()
    private let tutorialButton:UIButton = Buttons.getTutorialButton()
    
    private var titleLabel:UILabel!
    private var warningLabel:UILabel!
    
    private let container: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0, green: 0.1340581775, blue: 0.22262308, alpha: 1)
        v.layer.cornerRadius = 24
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    init() {
        super.init(frame: .zero)
        
        self.clipsToBounds = true
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        self.addSubview(container)
        
        // Labels
        self.titleLabel = EndgameView.newLabel(sizeFont: 40, w: .bold)
        self.container.addSubview(self.titleLabel)
        
        self.warningLabel = EndgameView.newLabel(sizeFont: 15, w: .semibold)
        self.warningLabel.textColor = .systemRed
        self.container.addSubview(self.warningLabel)
        
        // Botões
        self.container.addSubview(self.playButton)
        self.container.addSubview(self.homeButton)
        self.container.addSubview(self.achievmentsButton)
        self.container.addSubview(self.tutorialButton)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    /* MARK: Encapsulamento */
    
    public func getPlayButton() -> UIButton { return self.playButton }
    public func getHomeButton() -> UIButton { return self.homeButton }
    public func getAchievmentsButton() -> UIButton { return self.achievmentsButton }
    public func getTutorialButton() -> UIButton { return self.tutorialButton }
    
    public func setTitleLabel(text: String) { self.titleLabel.text = text }
    public func setWarningLabel(text: String) { self.warningLabel.text = text }
    
    
    /* MARK: Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        self.frame = (self.superview?.bounds)!
        
        // View em destaque
        self.container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        self.container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.35).isActive = true
        
        
        // Title label
        self.titleLabel.centerXAnchor.constraint(equalTo: self.container.centerXAnchor).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.playButton.topAnchor, constant:-30).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor).isActive = true
        
        
        // Botões
        self.playButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor).isActive = true
        self.playButton.centerYAnchor.constraint(equalTo: self.container.centerYAnchor).isActive = true
        
        
        self.achievmentsButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor).isActive = true
        self.achievmentsButton.topAnchor.constraint(equalTo: self.playButton.bottomAnchor, constant: 30).isActive = true
        
        
        self.tutorialButton.topAnchor.constraint(equalTo: self.achievmentsButton.topAnchor, constant: -6).isActive = true
        self.tutorialButton.leftAnchor.constraint(equalTo: self.achievmentsButton.rightAnchor, constant: 10).isActive = true

        
        self.homeButton.topAnchor.constraint(equalTo: self.achievmentsButton.topAnchor, constant: -6).isActive = true
        self.homeButton.rightAnchor.constraint(equalTo: self.achievmentsButton.leftAnchor, constant: -10).isActive = true
        
        
        // Warning label
        self.warningLabel.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -15).isActive = true
        self.warningLabel.centerXAnchor.constraint(equalTo: self.container.centerXAnchor).isActive = true
    }
}
