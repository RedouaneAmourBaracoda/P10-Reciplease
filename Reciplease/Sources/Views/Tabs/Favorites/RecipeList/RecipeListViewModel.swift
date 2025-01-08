//
//  RecipeListViewModel.swift
//  Reciplease
//
//  Created by Redouane on 03/12/2024.
//

import SwiftUI

final class RecipeListViewModel: ObservableObject {

    // MARK: - Properties

    let recipes: [Recipe]

    // MARK: - Initialization

    init(recipes: [Recipe] = []) {
        self.recipes = recipes
    }
}
