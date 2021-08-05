//
//  MenuView.swift
//  Ball Runner
//
//  Created by Gui Reis on 30/07/21.
//

import UIKit

class MenuView: UIView {
    var titleLabel:UILabel!
    var scoreLabel:UILabel!
    var warningLabel:UILabel!
    let playButton = Buttons().getPlayButton()
    let leaderboardButton = Buttons().getLeaderboardButton()
    let achievmentsButton = Buttons().getAchievmentButton()
    let tutorialButton = Buttons().getTutorialButton()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = #colorLiteral(red: 0, green: 0.1340581775, blue: 0.22262308, alpha: 1)
        
        self.warningLabel = self.newLabel(sizeFont: 15, w: .semibold)
        self.warningLabel.textColor = .systemRed
        self.addSubview(self.warningLabel)
        
        self.titleLabel = self.newLabel(sizeFont: 40, w: .bold)
        self.addSubview(self.titleLabel)
        
        self.scoreLabel = self.newLabel(sizeFont: 20, w: .medium)
        self.addSubview(self.scoreLabel)
        
        self.addSubview(self.playButton)
        self.addSubview(self.leaderboardButton)
        self.addSubview(self.achievmentsButton)
        self.addSubview(self.tutorialButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* MARK: Encapsulamento */
    
    public func getPlayButton() -> UIButton{return self.playButton}
    public func getLeaderboardButton() -> UIButton{return self.leaderboardButton}
    public func getAchievmentsButton() -> UIButton{return self.achievmentsButton}
    public func getTutorialButton() -> UIButton{return self.tutorialButton}

    public func setTitleLabel(text: String) -> Void{self.titleLabel.text = text}
    
    public func setScoreLabel(text: String) ->Void{self.scoreLabel.text = "Best " + text}
    
    public func setWarningLabel(text: String) ->Void{self.warningLabel.text = text}
        
    
    /* MARK: Funções de criação */
    
    private func newLabel(sizeFont:CGFloat, w:UIFont.Weight) -> UILabel{
        let lbl:UILabel = UILabel()
        lbl.font = .systemFont(ofSize: sizeFont, weight: w)
        lbl.textColor =  #colorLiteral(red: 0.9878974557, green: 0.9603099227, blue: 0.9356864095, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        return lbl
    }
    
    
    override func layoutSubviews() {
        let safeArea:CGFloat = 114
        
        self.warningLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -safeArea/2).isActive = true
        self.warningLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: safeArea+20).isActive = true
        self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        self.playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.playButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        self.achievmentsButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.achievmentsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -safeArea-20).isActive = true
        
        
        self.leaderboardButton.rightAnchor.constraint(equalTo: self.achievmentsButton.leftAnchor, constant: -25).isActive = true
        self.leaderboardButton.bottomAnchor.constraint(equalTo: self.achievmentsButton.bottomAnchor).isActive = true
        
        
        self.tutorialButton.leftAnchor.constraint(equalTo: self.achievmentsButton.rightAnchor, constant: 23).isActive = true
        self.tutorialButton.bottomAnchor.constraint(equalTo: self.achievmentsButton.bottomAnchor, constant: 5).isActive = true
        
        
        self.scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.scoreLabel.bottomAnchor.constraint(equalTo: self.achievmentsButton.topAnchor, constant: -50).isActive = true
    }
}
