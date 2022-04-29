/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class PauseView: UIView {
    private let playButton: UIButton = CustumView.newButton(for: .play, 60)
    private let homeButton: UIButton = CustumView.newButton(for: .home)
    private let achievmentsButton: UIButton = CustumView.newButton(for: .achievments)
    private let tutorialButton: UIButton = CustumView.newButton(for: .tutorial)
    
    private var titleLabel: UILabel = CustumView.newLabel(sizeFont: 40, weight: .bold)
    private var warningLabel: UILabel = CustumView.newLabel(sizeFont: 15, weight: .semibold)
    
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
        
        self.warningLabel.textColor = .systemRed
        
        self.addSubview(container)
        
        // Labels
        self.container.addSubview(self.titleLabel)
        self.container.addSubview(self.warningLabel)
        
        // Botões
        self.container.addSubview(self.playButton)
        self.container.addSubview(self.homeButton)
        self.container.addSubview(self.achievmentsButton)
        self.container.addSubview(self.tutorialButton)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    /* MARK: - Encapsulamento */
    
    public func setHomeAction(target: UIViewController, action: Selector) -> Void {
        self.homeButton.addTarget(target, action: action, for: .touchDown)
    }

    
    public func setTutorialAction(target: UIViewController, action: Selector) -> Void {
        self.tutorialButton.addTarget(target, action: action, for: .touchDown)
    }
    
    public func setPlayAction(target: UIViewController, action: Selector) -> Void {
        self.playButton.addTarget(target, action: action, for: .touchDown)
    }
    
    public func setAchievmentsAction(target: UIViewController, action: Selector) -> Void {
        self.achievmentsButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    public func setTitleText(with text: String) { self.titleLabel.text = text }
    public func setWarningText(with text: String) { self.warningLabel.text = text }
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        self.frame = (self.superview?.bounds)!
        
        NSLayoutConstraint.activate([
            // View em destaque
            self.container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            self.container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.35),
            
            
            // Title label
            self.titleLabel.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.playButton.topAnchor, constant:-30),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 45),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            
            
            // Botões
            self.playButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
            self.playButton.centerYAnchor.constraint(equalTo: self.container.centerYAnchor),
            
            
            self.achievmentsButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
            self.achievmentsButton.topAnchor.constraint(equalTo: self.playButton.bottomAnchor, constant: 30),
            
            
            self.tutorialButton.topAnchor.constraint(equalTo: self.achievmentsButton.topAnchor, constant: -6),
            self.tutorialButton.leftAnchor.constraint(equalTo: self.achievmentsButton.rightAnchor, constant: 10),

            
            self.homeButton.topAnchor.constraint(equalTo: self.achievmentsButton.topAnchor, constant: -6),
            self.homeButton.rightAnchor.constraint(equalTo: self.achievmentsButton.leftAnchor, constant: -10),
            
            
            // Warning label
            self.warningLabel.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -15),
            self.warningLabel.centerXAnchor.constraint(equalTo: self.container.centerXAnchor)
        ])
    }
}
