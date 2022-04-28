/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class EndgameView: UIView {
    
    /* MARK: - Atributos */
    
    private var titleLabel: UILabel = EndgameView.newLabel(sizeFont: 40, w: .bold)
    private var scoreTitleLabel: UILabel = EndgameView.newLabel(sizeFont: 20, w: .medium)
    private var scoreLabel: UILabel = EndgameView.newLabel(sizeFont: 30, w: .semibold)
    private var bestTitleLabel: UILabel = EndgameView.newLabel(sizeFont: 20, w: .medium)
    private var bestLabel: UILabel = EndgameView.newLabel(sizeFont: 30, w: .semibold)
    
    private let restartButton = Buttons.getRestartButton()
    private let shareButton = Buttons.getShareButton()
    
    
    
    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = #colorLiteral(red: 0, green: 0.1340581775, blue: 0.22262308, alpha: 1)
        
        // Labels
        self.addSubview(self.titleLabel)
        self.addSubview(self.scoreTitleLabel)
        self.addSubview(self.scoreLabel)
        self.addSubview(self.bestTitleLabel)
        self.addSubview(self.bestLabel)

        // Botões
        self.addSubview(self.restartButton)
        self.addSubview(self.shareButton)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    /* MARK: - Encapsulamento */
    
    public func setRestartAction(target: UIViewController, action: Selector) -> Void {
        self.restartButton.addTarget(target, action: action, for: .touchDown)
    }
    
    public func setShareAction(target: UIViewController, action: Selector) -> Void {
        self.shareButton.addTarget(target, action: action, for: .touchDown)
    }

    
    public func setScore(with score: Int) -> Void { self.scoreLabel.text = "\(score)" }
    public func setBestScore(with score: Int) -> Void { self.bestLabel.text = "\(score)" }
    public func setTitleLabels(list: [String]) -> Void {
        self.titleLabel.text = list[0]
        self.scoreTitleLabel.text = list[1]
        self.bestTitleLabel.text = list[2]
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
            self.shareButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -safeArea-20)
        ])
    }
    
    
    /* MARK: - Funções de criação */
    
    public static func newLabel(sizeFont: CGFloat, w: UIFont.Weight) -> UILabel {
        let lbl:UILabel = UILabel()
        lbl.font = .systemFont(ofSize: sizeFont, weight: w)
        lbl.textColor =  #colorLiteral(red: 0.9878974557, green: 0.9603099227, blue: 0.9356864095, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        return lbl
    }
}
