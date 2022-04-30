/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class UIKit.UIColor


extension UIColor {
    
    convenience init?(with color: Colors) {
        self.init(named: color.description)
    }
}
