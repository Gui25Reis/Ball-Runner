/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import Foundation

extension UserDefaults {
    
    /// Atualiza um valor
    internal static func updateValue(in key: UserDefaultsKeys, with value: Any) {
        UserDefaults.standard.set(value, forKey: key.description)
    }
    
    /// Retorna um valor inteiro
    internal static func getIntValue(with key: UserDefaultsKeys) -> Int {
        return UserDefaults.standard.integer(forKey: key.description)
    }
    
    /// Retorna um valor boleano
    internal static func getBoolValue(with key: UserDefaultsKeys) -> Bool {
        return UserDefaults.standard.bool(forKey: key.description)
    }
}
