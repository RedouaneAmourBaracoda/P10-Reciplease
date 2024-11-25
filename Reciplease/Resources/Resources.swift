//
//  Resources.swift
//  Reciplease
//
//  Created by Redouane on 25/11/2024.
//

import SwiftUI

enum CustomFonts {
    static let body = "SueEllenFrancisco"
}

enum CustomColors {
    static let main = Color("main-color", bundle: .main)
}

enum Localizable {
    static let undeterminedErrorDescription = NSLocalizedString(
        "recipe.errors.undetermined.description",
        comment: ""
    )

    static let searchButtonTitle = NSLocalizedString(
        "recipe.search-button.title",
        comment: ""
    )
}
