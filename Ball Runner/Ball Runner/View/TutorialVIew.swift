/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class TutorialView: CustumView {
    
    /* MARK: - Atributos */
    
    private var titleLabel: UILabel = CustumView.newLabelToFit(sizeFont: 40, weight: .bold)
    private var viewGroups: [UIView] = []
    private var subTitlelabels: [UILabel] = []
    private var descriptionLabels: [UILabel] = []
    
    private var viewToAnimate:[[UIView]] = []
    
    private let exitButton: UIButton = CustumView.newButton(for: .exit)
    
    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        
        self.clipsToBounds = true
    
        self.addSubview(self.titleLabel)
        self.addSubview(self.exitButton)
        
        
        for x in 0..<3{
            let view = UIView(frame: .zero)
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
            
            // Labels
            self.subTitlelabels.append(CustumView.newLabelToFit(sizeFont: 30, weight: .semibold))
            view.addSubview(self.subTitlelabels[x])
            
            self.descriptionLabels.append(CustumView.newLabelToFit(sizeFont: 25, weight: .regular))
            view.addSubview(self.descriptionLabels[x])
            
            /* TODO: Animar */
            
            // Views com animações
            var list:[UIView] = []
            
            list.append(TutorialView.particle(color: 0))
            
            switch x {
            case 0:
                list.append(TutorialView.particle(color: 1))
            case 1:
                list.append(self.newImageView(icon: "hand.point.up.left", isSFSymbol: true))
            default:
                list.append(TutorialView.particle(color: 1))
                list.append(TutorialView.particle(color: 2))
            }
            
            for v in list {
                view.addSubview(v)
            }
            self.viewToAnimate.append(list)
            self.viewGroups.append(view)
        }
    }

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    /* MARK: - Encapsulamento */
    
    public func setTitleText(with text: String) -> Void { self.titleLabel.text = text }
    
    public func setTutorialTopics(with topics: [TutorialTopic]) -> Void {
        for topic in 0..<topics.count {
            self.subTitlelabels[topic].text = topics[topic].title
            self.descriptionLabels[topic].text = topics[topic].description
        }
    }
    
    public func setExitAction(target: UIViewController, action: Selector) -> Void {
        self.exitButton.addTarget(target, action: action, for: .touchDown)
    }
    
        
    /* MARK: - Ciclo de vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        let border: CGFloat = 15
        
        /* Parte de cima */
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: border).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        self.exitButton.topAnchor.constraint(equalTo: self.titleLabel.topAnchor).isActive = true
        self.exitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -border/2).isActive = true
        
        

        for x in 0..<3 {
            /* Grupos */
            self.viewGroups[x].heightAnchor.constraint(equalToConstant: self.bounds.height * 0.25).isActive = true
            self.viewGroups[x].leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: border).isActive = true
            self.viewGroups[x].trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -border).isActive = true

            if (x-1 < 0) {
                self.viewGroups[x].topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15).isActive = true
            } else {
                self.viewGroups[x].topAnchor.constraint(equalTo: self.viewGroups[x-1].bottomAnchor, constant: 15).isActive = true
            }
            
            
            /* Labels */
            self.descriptionLabels[x].topAnchor.constraint(equalTo: self.subTitlelabels[x].bottomAnchor, constant: 7).isActive = true
            self.descriptionLabels[x].leadingAnchor.constraint(equalTo: self.viewGroups[x].leadingAnchor).isActive = true
            self.descriptionLabels[x].trailingAnchor.constraint(equalTo: self.viewGroups[x].trailingAnchor).isActive = true
            
            
            /* Animações */
            let list:[UIView] = self.viewToAnimate[x]
            
            
            if x < 2 {
                var space: CGFloat = -40
                if x == 0 {space = 20}
                
                list[0].centerXAnchor.constraint(equalTo: self.viewGroups[x].centerXAnchor, constant: space).isActive = true
                list[0].topAnchor.constraint(equalTo: self.descriptionLabels[x].bottomAnchor, constant: abs(space)).isActive = true
                
                list[1].centerXAnchor.constraint(equalTo: self.viewGroups[x].centerXAnchor, constant: -space).isActive = true
                list[1].topAnchor.constraint(equalTo: list[0].topAnchor).isActive = true
            } else {
                list[0].centerXAnchor.constraint(equalTo: self.viewGroups[x].centerXAnchor).isActive = true
                list[0].topAnchor.constraint(equalTo: self.descriptionLabels[x].bottomAnchor, constant: 40).isActive = true
                
                list[1].centerXAnchor.constraint(equalTo: self.viewGroups[x].centerXAnchor, constant: -70).isActive = true
                list[1].topAnchor.constraint(equalTo: list[0].topAnchor).isActive = true
                
                list[2].centerXAnchor.constraint(equalTo: self.viewGroups[x].centerXAnchor, constant: 70).isActive = true
                list[2].topAnchor.constraint(equalTo: list[0].topAnchor, constant: 0).isActive = true
                // constant: -5 -> com imagem do poder
            }
        }
    }
    
    
    /* MARK: - Funções de criação */
    
    static func particle(color: Int) -> UIView {
        let v = UIView(frame: .zero)
        v.layer.cornerRadius = 7
        
        if (color == 1) {v.backgroundColor = #colorLiteral(red: 0.8296997547, green: 0.2501699328, blue: 0.2907564044, alpha: 1)}
        else if (color == 2) {v.backgroundColor = #colorLiteral(red: 0.9878974557, green: 0.9603099227, blue: 0.9356864095, alpha: 1)}
        else {v.backgroundColor = #colorLiteral(red: 0, green: 0.9089414477, blue: 0.4565228224, alpha: 1)}
        
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: 15).isActive = true
        v.widthAnchor.constraint(equalToConstant: 15).isActive = true
        return v
    }
    
    
    private func newImageView(icon: String, isSFSymbol: Bool) -> UIImageView {
        var img: UIImage!
        
        if (isSFSymbol) {
            let configIcon = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .medium)
            img = UIImage(systemName: icon, withConfiguration: configIcon)?.withRenderingMode(.alwaysTemplate)
        } else {
            img = UIImage(named: icon)?.withRenderingMode(.alwaysTemplate)
        }
        
        let imgView = UIImageView(image: img)
        imgView.tintColor = #colorLiteral(red: 0.9878974557, green: 0.9603099227, blue: 0.9356864095, alpha: 1)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }
}
