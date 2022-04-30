/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class EndgameView: CustumView {
    
    /* MARK: - Atributos */
    
    private var titleLabel: UILabel = CustumView.newLabel(sizeFont: 40, weight: .bold)
    private var scoreTitleLabel: UILabel = CustumView.newLabel(sizeFont: 20, weight: .medium)
    private var scoreLabel: UILabel = CustumView.newLabel(sizeFont: 30, weight: .semibold)
    private var bestTitleLabel: UILabel = CustumView.newLabel(sizeFont: 20, weight: .medium)
    private var bestLabel: UILabel = CustumView.newLabel(sizeFont: 30, weight: .semibold)
    private var warningLabel = CustumView.newLabel(sizeFont: 15, weight: .semibold)
    
    private let restartButton = CustumView.newButton(for: .restart)
    private let shareButton = CustumView.newButton(for: .share)
    
    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        self.warningLabel.textColor = .systemRed
        
        // Labels
        self.addSubview(self.titleLabel)
        self.addSubview(self.scoreTitleLabel)
        self.addSubview(self.scoreLabel)
        self.addSubview(self.bestTitleLabel)
        self.addSubview(self.bestLabel)
        self.addSubview(self.warningLabel)

        // Botões
        self.addSubview(self.restartButton)
        self.addSubview(self.shareButton)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    /* MARK: - Encapsulamento */
    
    /* Definindo as ações dos botões */
    public func setRestartAction(target: UIViewController, action: Selector) -> Void {
        self.restartButton.addTarget(target, action: action, for: .touchDown)
    }
    
    public func setShareAction(target: UIViewController, action: Selector) -> Void {
        self.shareButton.addTarget(target, action: action, for: .touchDown)
    }

    
    /* Definindo os textos */
    public func setWarningText(with text: String) -> Void { self.warningLabel.text = text }
    
    public func setScore(with score: Int) -> Void { self.scoreLabel.text = "\(score)" }
    
    public func setBestScore(with score: Int) -> Void { self.bestLabel.text = "\(score)" }
    
    public func setTitleLabels(list: [String]) -> Void {
        self.titleLabel.text = list[0]
        self.scoreTitleLabel.text = list[1]
        self.bestTitleLabel.text = list[2]
    }
    
    
    public func setShareVisibility(for visibility: Bool) -> Void {
        self.shareButton.isHidden = !visibility
    }
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        let safeArea: CGFloat = 114      // Popup game center
        
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: safeArea+20),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            
            self.scoreTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 50),
            self.scoreTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scoreTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(self.bounds.width/2)),
            
            
            self.scoreLabel.topAnchor.constraint(equalTo: self.scoreTitleLabel.bottomAnchor, constant: 10),
            self.scoreLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scoreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(self.bounds.width/2)),
            
            
            self.bestTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 50),
            self.bestTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.bounds.width/2),
            self.bestTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
            self.bestLabel.topAnchor.constraint(equalTo: self.bestTitleLabel.bottomAnchor, constant: 10),
            self.bestLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.bounds.width/2),
            self.bestLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
            self.restartButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.restartButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            
            self.shareButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.shareButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -safeArea-20),
            
            
            self.warningLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -safeArea/2),
            self.warningLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
