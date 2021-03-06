/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class MenuView: CustumView {
    
    /* MARK: - Atributos */
    
    private var titleLabel = CustumView.newLabel(sizeFont: 40, weight: .bold)
    private var scoreLabel = CustumView.newLabel(sizeFont: 20, weight: .medium)
    private var warningLabel = CustumView.newLabel(sizeFont: 15, weight: .semibold)
    private let playButton = CustumView.newButton(for: .play)
    private let leaderboardButton = CustumView.newButton(for: .leaderboard)
    private let achievmentsButton = CustumView.newButton(for: .achievments)
    private let tutorialButton = CustumView.newButton(for: .tutorial)
    
    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        self.warningLabel.textColor = .systemRed
        
        self.addSubview(self.warningLabel)
        self.addSubview(self.titleLabel)
        self.addSubview(self.scoreLabel)
        
        self.addSubview(self.playButton)
        self.addSubview(self.leaderboardButton)
        self.addSubview(self.achievmentsButton)
        self.addSubview(self.tutorialButton)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    /* MARK: - Encapsulamento */
    
    /* Definindo as ações dos botões */
    public func setPlayAction(target: UIViewController, action: Selector) -> Void {
        self.playButton.addTarget(target, action: action, for: .touchDown)
    }
    
    public func setLeaderboardAction(target: UIViewController, action: Selector) -> Void {
        self.leaderboardButton.addTarget(target, action: action, for: .touchDown)
    }
    
    public func setAchievmentsAction(target: UIViewController, action: Selector) -> Void {
        self.achievmentsButton.addTarget(target, action: action, for: .touchDown)
    }
    
    public func setTutorialAction(target: UIViewController, action: Selector) -> Void {
        self.tutorialButton.addTarget(target, action: action, for: .touchDown)
    }
    
    /* Definindo os textos */
    public func setTitleText(with text: String) -> Void { self.titleLabel.text = text }
    
    public func setWarningText(with text: String) -> Void { self.warningLabel.text = text }
    
    public func setScore(with score: Int) -> Void {
        self.scoreLabel.text = "Best".localized() + " \(score)"
    }
        
        
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        let safeArea: CGFloat = 114
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: safeArea+0),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            
            self.playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.playButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            
            self.achievmentsButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.achievmentsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -safeArea-0),
            
            
            self.leaderboardButton.rightAnchor.constraint(equalTo: self.achievmentsButton.leftAnchor, constant: -25),
            self.leaderboardButton.bottomAnchor.constraint(equalTo: self.achievmentsButton.bottomAnchor),
            
            
            self.tutorialButton.leftAnchor.constraint(equalTo: self.achievmentsButton.rightAnchor, constant: 20),
            self.tutorialButton.bottomAnchor.constraint(equalTo: self.achievmentsButton.bottomAnchor, constant: 5),
            
            
            self.scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.scoreLabel.bottomAnchor.constraint(equalTo: self.achievmentsButton.topAnchor, constant: -50),
                    
            
            self.warningLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -safeArea/2),
            self.warningLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
