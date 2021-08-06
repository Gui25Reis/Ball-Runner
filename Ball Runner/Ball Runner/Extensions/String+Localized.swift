/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import func Foundation.NSLocalizedString


extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localization",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}
