/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class MenuView: UIView {
    private var titleLabel:UILabel!
    private var scoreLabel:UILabel!
    private var warningLabel:UILabel!
    private let playButton = Buttons.getPlayButton()
    private let leaderboardButton = Buttons.getLeaderboardButton()
    private let achievmentsButton = Buttons.getAchievmentButton()
    private let tutorialButton = Buttons.getTutorialButton()
    
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = #colorLiteral(red: 0, green: 0.1340581775, blue: 0.22262308, alpha: 1)
        
        self.warningLabel = EndgameView.newLabel(sizeFont: 15, w: .semibold)
        self.warningLabel.textColor = .systemRed
        self.addSubview(self.warningLabel)
        
        self.titleLabel = EndgameView.newLabel(sizeFont: 40, w: .bold)
        self.addSubview(self.titleLabel)
        
        self.scoreLabel = EndgameView.newLabel(sizeFont: 20, w: .medium)
        self.addSubview(self.scoreLabel)
        
        self.addSubview(self.playButton)
        self.addSubview(self.leaderboardButton)
        self.addSubview(self.achievmentsButton)
        self.addSubview(self.tutorialButton)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    /* MARK: - Encapsulamento */
    
    public func getPlayButton() -> UIButton { return self.playButton }
    public func getLeaderboardButton() -> UIButton { return self.leaderboardButton }
    public func getAchievmentsButton() -> UIButton { return self.achievmentsButton }
    public func getTutorialButton() -> UIButton { return self.tutorialButton }

    public func setTitleLabel(text: String) -> Void { self.titleLabel.text = text }
    public func setWarningLabel(text: String) -> Void { self.warningLabel.text = text }
    public func setScoreLabel(text: String) -> Void { self.scoreLabel.text = text }
    public func getScoreLabel() -> UILabel { return self.scoreLabel }
        
        
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        /*
        // Auto Layout:
        // print((self.superview?.bounds.height)!)
        self.scoreLabel.font = .systemFont(ofSize: (self.superview?.bounds.height)! * 0.0236, weight: .medium)

        self.titleLabel.font = .systemFont(ofSize: (self.superview?.bounds.height)! * 0.0473, weight: .bold)

        self.warningLabel.font = .systemFont(ofSize: (self.superview?.bounds.height)! * 0.0473, weight: .bold)
        */
        
        // Constraints
        let safeArea:CGFloat = 114
        
        
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: safeArea+0).isActive = true
        self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        self.playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.playButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        self.achievmentsButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.achievmentsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -safeArea-0).isActive = true
        
        
        self.leaderboardButton.rightAnchor.constraint(equalTo: self.achievmentsButton.leftAnchor, constant: -25).isActive = true
        self.leaderboardButton.bottomAnchor.constraint(equalTo: self.achievmentsButton.bottomAnchor).isActive = true
        
        
        self.tutorialButton.leftAnchor.constraint(equalTo: self.achievmentsButton.rightAnchor, constant: 20).isActive = true
        self.tutorialButton.bottomAnchor.constraint(equalTo: self.achievmentsButton.bottomAnchor, constant: 5).isActive = true
        
        
        self.scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.scoreLabel.bottomAnchor.constraint(equalTo: self.achievmentsButton.topAnchor, constant: -50).isActive = true
                
        
        self.warningLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -safeArea/2).isActive = true
        self.warningLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
