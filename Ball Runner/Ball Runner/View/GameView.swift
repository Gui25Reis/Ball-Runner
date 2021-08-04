//
//  GameView.swift
//  Ball Runner
//
//  Created by Gui Reis on 21/07/21.
//

import SpriteKit


class GameView: UIView {
    var pauseButton: UIButton = Buttons().getPauseButton()
    
    var gameScene: SKView = {
        let v = SKView()
        v.layer.cornerRadius = 20
        v.layer.masksToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var timeLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.9878974557, green: 0.9603099227, blue: 0.9356864095, alpha: 1)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = #colorLiteral(red: 0, green: 0.1340581775, blue: 0.22262308, alpha: 1)
        
        self.addSubview(self.gameScene)
        self.addSubview(self.pauseButton)
        self.addSubview(self.timeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func getPauseButton() -> UIButton {return self.pauseButton}
    
    public func getTimeLabel() -> UILabel {return self.timeLabel}
    
    public func setTimeLabel(text: String) -> Void {self.timeLabel.text = text}
    
    public func setScene(scene: SKScene) {self.gameScene.presentScene(scene)}
    
    
    public func showInformations(is_: Bool) {
        self.gameScene.showsFPS = is_                                // Mostra o fps
        self.gameScene.showsNodeCount = is_                          // Mostra a quantidade de nodes que tem
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
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
}
