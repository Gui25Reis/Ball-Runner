//
//  UIColor+Colors.swift
//  Ball Runner
//
//  Created by Gui Reis on 29/04/22.
//

import class UIKit.UIColor

extension UIColor {
    
    convenience init?(with color: Colors) {
        self.init(named: color.description)
    }
}
