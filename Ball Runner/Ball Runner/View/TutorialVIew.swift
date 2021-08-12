/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class TutorialView: UIView {
    private let lineView:UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 4
        view.backgroundColor = #colorLiteral(red: 0.9878974557, green: 0.9603099227, blue: 0.9356864095, alpha: 1)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var titleLabel:UILabel!
    private var viewGroups:[UIView] = []
    private var subTitlelabels:[UILabel] = []
    private var descriptionLabels:[UILabel] = []
    
    private var viewToAnimate:[[UIView]] = []
    private var powerSimbol:UIImageView!
    
    private let exitButton:UIButton = Buttons.getExitButton()
    
    
    init() {
        super.init(frame: .zero)
        
        self.clipsToBounds = true
        self.backgroundColor = #colorLiteral(red: 0, green: 0.1340581775, blue: 0.22262308, alpha: 1)
        
        self.addSubview(self.lineView)
        
        self.titleLabel = self.newLabel(sizeFont: 40, w: .bold)
        self.addSubview(self.titleLabel)
        
        self.addSubview(self.exitButton)
        
        
        for x in 0..<3{
            let v = UIView(frame: .zero)
            v.translatesAutoresizingMaskIntoConstraints = false
        
            self.addSubview(v)
            
            
            // Labels
            self.subTitlelabels.append(self.newLabel(sizeFont: 30, w: .semibold))
            v.addSubview(self.subTitlelabels[x])
            
            self.descriptionLabels.append(self.newLabel(sizeFont: 25, w: .regular))
            v.addSubview(self.descriptionLabels[x])
            
            self.viewGroups.append(v)
            
            
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
                //list.append(self.newImageView(icon: "power06.svg", isSFSymbol: false))
            }
            
            for y in list {self.viewGroups[x].addSubview(y)}
            self.viewToAnimate.append(list)
        }
    }
        
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    /* MARK: Encapsulamento */
    
    public func setTitleLabel(text: String) -> Void { self.titleLabel.text = text }
    
    public func setSubTitleLabels(list: [String]) -> Void {for x in 0..<3 { self.subTitlelabels[x].text = list[x]} }
    
    public func setDescriptionLabels(list: [String]) -> Void { for x in 0..<3 {self.descriptionLabels[x].text = list[x]} }
    
    public func getExitButton() -> UIButton { return self.exitButton }
    
    public func getObjectsToAnimate() -> [[UIView]] { return self.viewToAnimate }
    
        
    /* MARK: Ciclo de vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        let border:CGFloat = 15
        
        /* Parte de cima */
        self.lineView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        self.lineView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.lineView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        self.lineView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        self.titleLabel.topAnchor.constraint(equalTo: self.lineView.topAnchor, constant: 25).isActive = true
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
            }else{
                self.viewGroups[x].topAnchor.constraint(equalTo: self.viewGroups[x-1].bottomAnchor, constant: 15).isActive = true
            }
            
            
            /* Labels */
            self.descriptionLabels[x].topAnchor.constraint(equalTo: self.subTitlelabels[x].bottomAnchor, constant: 7).isActive = true
            self.descriptionLabels[x].leadingAnchor.constraint(equalTo: self.viewGroups[x].leadingAnchor).isActive = true
            self.descriptionLabels[x].trailingAnchor.constraint(equalTo: self.viewGroups[x].trailingAnchor).isActive = true
            
            
            /* Animações */
            let list:[UIView] = self.viewToAnimate[x]
            
            
            if x < 2 {
                var space:CGFloat!
                if x == 0 {space = 20}
                else {space = -40}
                
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
    
    
    /* MARK: Funções de criação */
    
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
    
    private func newLabel(sizeFont:CGFloat, w:UIFont.Weight) -> UILabel {
        let lbl:UILabel = EndgameView.newLabel(sizeFont: sizeFont, w: w)
        lbl.textAlignment = .left
        lbl.sizeToFit()
        lbl.numberOfLines = 0
        return lbl
    }
    
    private func newImageView(icon: String, isSFSymbol: Bool) -> UIImageView {
        var img:UIImage!
        
        if (isSFSymbol) {
            let configIcon = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .medium)
            img = UIImage(systemName: icon, withConfiguration: configIcon)?.withRenderingMode(.alwaysTemplate)
        }else{
            img = UIImage(named: icon)?.withRenderingMode(.alwaysTemplate)
        }
        
        let imgView = UIImageView(image: img)
        imgView.tintColor = #colorLiteral(red: 0.9878974557, green: 0.9603099227, blue: 0.9356864095, alpha: 1)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }
}
