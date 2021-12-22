//
//  GameViiew.swift
//  Drink Game
//
//  Created by Gui Reis on 31/07/21.
//

import UIKit

class WarningView: UIView {
    let container:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0, green: 0.1340581775, blue: 0.22262308, alpha: 1)
        v.layer.cornerRadius = 24
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let exitButton:UIButton = {
        let bt = UIButton()
        bt.layer.cornerRadius = 10
        bt.layer.borderWidth = 3.0
        bt.layer.borderColor = #colorLiteral(red: 0.9878974557, green: 0.9603099227, blue: 0.9356864095, alpha: 1)
        bt.setTitleColor(#colorLiteral(red: 0.9878974557, green: 0.9603099227, blue: 0.9356864095, alpha: 1), for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
        
    var descriptionLabel:UILabel!
    var titleLabel:UILabel!
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        self.addSubview(self.container)
        
        self.titleLabel = self.newLabel(sizeFont: 60, w: .semibold, numLines: 2)
        self.container.addSubview(self.titleLabel)
        
        self.descriptionLabel = self.newLabel(sizeFont: 22, w: .regular, numLines: 0)
        self.descriptionLabel.textAlignment = .left
        // self.descriptionLabel.backgroundColor = .red
        self.container.addSubview(self.descriptionLabel)
        
        self.container.addSubview(self.exitButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /* MARK: - Encapsulamento */
    
    public func setDescriptionLabel(text:String) -> Void {self.descriptionLabel.text = text}
    public func getDescriptionLabel() -> UILabel {return self.descriptionLabel}
    
    public func setTitleLabel(text:String) -> Void {self.titleLabel.text = text}
    public func getTitleLabel() -> UILabel {return self.titleLabel}
    
    public func getExitButton() -> UIButton {return self.exitButton}
    
    /* MARK: - Criação */
    
    private func newLabel(sizeFont:CGFloat, w:UIFont.Weight, numLines:Int) -> UILabel {
        let lbl:UILabel = UILabel(frame: .zero)
        lbl.font = .systemFont(ofSize: sizeFont, weight: w)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.textAlignment = .center
        lbl.sizeToFit()
        lbl.numberOfLines = numLines
        lbl.textColor = #colorLiteral(red: 0.9878974557, green: 0.9603099227, blue: 0.9356864095, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
        
    
    /* MARK: - Constraints */
    
    override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        self.frame = (self.superview?.bounds)!
        
        
        self.container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        self.container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        
        
        self.titleLabel.centerXAnchor.constraint(equalTo: self.container.centerXAnchor).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 10).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -10).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 10).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        self.exitButton.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 70).isActive = true
        self.exitButton.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -70).isActive = true
        self.exitButton.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -10).isActive = true
        self.exitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        self.descriptionLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 10).isActive = true
        self.descriptionLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -10).isActive = true
        self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10).isActive = true
        self.descriptionLabel.bottomAnchor.constraint(equalTo: self.exitButton.topAnchor, constant: -10).isActive = true
    }
}
