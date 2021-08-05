//
//  String+Localized.swift
//  Ball Runner
//
//  Created by Gui Reis on 05/08/21.
//

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
