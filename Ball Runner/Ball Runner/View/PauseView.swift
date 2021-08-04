//
//  PauseView.swift
//  Ball Runner
//
//  Created by Gui Reis on 22/07/21.
//

import UIKit

class PauseView: UIView {
    var playButton: UIButton = Buttons().getPlayButton(60)
    var homeButton: UIButton = Buttons().getHomeButton()
    var achievmentsButton: UIButton = Buttons().getAchievmentButton()
    var tutorialButton: UIButton = Buttons().getTutorialButton()
    
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 0, green: 0.1340581775, blue: 0.22262308, alpha: 1)
        v.layer.cornerRadius = 24
        return v
    }()
    
    var titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.9878974557, green: 0.9603099227, blue: 0.9356864095, alpha: 1)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.clipsToBounds = true
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        self.addSubview(container)
        
        // Labels
        self.container.addSubview(self.titleLabel)
        
        // Botões
        self.container.addSubview(self.playButton)
        
        self.container.addSubview(self.homeButton)
        
        self.container.addSubview(self.achievmentsButton)
        
        self.container.addSubview(self.tutorialButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* MARK: Encapsulamento */
    public func getPlayButton() -> UIButton {return self.playButton}
    
    public func getHomeButton() -> UIButton {return self.homeButton}
    
    public func getAchievmentsButton() -> UIButton {return self.achievmentsButton}
    
    public func getTutorialButton() -> UIButton {return self.tutorialButton}
    
    public func setTitleLabel(text: String) {self.titleLabel.text = text}
    

    override func layoutSubviews() {
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
    }
}
