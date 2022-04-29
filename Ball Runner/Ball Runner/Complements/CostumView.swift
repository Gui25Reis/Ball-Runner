/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class CustumView: UIView {
    
    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(with: .background)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    /* MARK: Botões */
    
    private static func createButton(with button: Button, _ isIcon: Bool = true, _ sizeFont: CGFloat = 30, _ corner: CGFloat = 50) -> UIButton {
        let bt = UIButton()
        
        // Imagem
        var image: UIImage!
        
        switch isIcon {
        case true:
            let configIcon = UIImage.SymbolConfiguration(pointSize: sizeFont, weight: .bold, scale: .large)
            image = UIImage(systemName: button.description, withConfiguration: configIcon)
            
        case false:
            image = UIImage(named: button.description)?.withRenderingMode(.alwaysTemplate)
        }
        
        bt.setImage(image, for: .normal)
        
        // Geral
        bt.tintColor = UIColor(with: .button)
        bt.backgroundColor = UIColor(with: .background)
        
        // Constraints
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.widthAnchor.constraint(equalToConstant: corner).isActive = true
        bt.heightAnchor.constraint(equalToConstant: corner).isActive = true
        return bt
    }
    
    public static func newButton(for button: Button, _ size: CGFloat = 80) -> UIButton {
        switch button {
        case .home, .pause, .tutorial, .back, .exit:
            return self.createButton(with: button)
        case .restart:
            return self.createButton(with: button, true, 80, 80)
        case .play:
            return self.createButton(with: button, true, size, size)
        case .share, .achievments, .leaderboard:
            return self.createButton(with: button, false, 25, 40)
        }
    }
    
    
    /* MARK: Label */
    
    public static func newLabel(sizeFont: CGFloat, weight: UIFont.Weight) -> UILabel {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: sizeFont, weight: weight)
        lbl.textColor = UIColor(with: .text)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
    
    public static func newLabelToFit(sizeFont: CGFloat, weight: UIFont.Weight) -> UILabel {
        let lbl = self.newLabel(sizeFont: sizeFont, weight: weight)
        lbl.textAlignment = .left
        lbl.sizeToFit()
        lbl.numberOfLines = 0
        return lbl
    }
}
