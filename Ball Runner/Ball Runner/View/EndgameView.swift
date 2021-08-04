//
//  EndgameView.swift
//  Ball Runner
//
//  Created by Gui Reis on 30/07/21.
//

import UIKit

class EndgameView: UIView {
    var titleLabel:UILabel!
    var scoreTitleLabel:UILabel!
    var scoreLabel:UILabel!
    var bestTitleLabel:UILabel!
    var bestLabel:UILabel!
    
    let restartButton = Buttons().getRestartButton()
    let shareButton = Buttons().getShareButton()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = #colorLiteral(red: 0, green: 0.1340581775, blue: 0.22262308, alpha: 1)
        
        self.titleLabel = self.newLabel(sizeFont: 40, w: .bold)
        self.scoreTitleLabel = self.newLabel(sizeFont: 20, w: .medium)
        self.scoreLabel = self.newLabel(sizeFont: 30, w: .semibold)
        self.bestTitleLabel = self.newLabel(sizeFont: 20, w: .medium)
        self.bestLabel = self.newLabel(sizeFont: 30, w: .semibold)

        self.addSubview(self.restartButton)
        self.addSubview(self.shareButton)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    /* MARK: Encapsulamento */
    
    public func getRestartButton() -> UIButton{return self.restartButton}
    public func getShareButton() -> UIButton{return self.shareButton}
    
    public func setScoreLabel(text: String) -> Void{self.scoreLabel.text = text}
    public func setBestLabel(text: String) -> Void{self.bestLabel.text = text}
    public func setTitleLabels(list: [String]) -> Void {
        self.titleLabel.text = list[0]
        self.scoreTitleLabel.text = list[1]
        self.bestTitleLabel.text = list[2]
    }
    
    
    
    /* MARK: Funções de criação */
    
    private func newLabel(sizeFont:CGFloat, w:UIFont.Weight) -> UILabel{
        let lbl:UILabel = UILabel()
        lbl.font = .systemFont(ofSize: sizeFont, weight: w)
        lbl.textColor =  #colorLiteral(red: 0.9878974557, green: 0.9603099227, blue: 0.9356864095, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        
        self.addSubview(lbl)
        return lbl
    }
    
    
    override func layoutSubviews() {
        let safeArea:CGFloat = 114  // Popup game center
        
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: safeArea+20).isActive = true
        self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        self.scoreTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 50).isActive = true
        self.scoreTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.scoreTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(self.bounds.width/2)).isActive = true
        
        
        self.scoreLabel.topAnchor.constraint(equalTo: self.scoreTitleLabel.bottomAnchor, constant: 10).isActive = true
        self.scoreLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.scoreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(self.bounds.width/2)).isActive = true
        
        
        self.bestTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 50).isActive = true
        self.bestTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.bounds.width/2).isActive = true
        self.bestTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        
        self.bestLabel.topAnchor.constraint(equalTo: self.bestTitleLabel.bottomAnchor, constant: 10).isActive = true
        self.bestLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.bounds.width/2).isActive = true
        self.bestLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        
        self.restartButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.restartButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        self.shareButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.shareButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -safeArea-20).isActive = true
    }
}
