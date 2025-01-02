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

    let favoriteRecipes: [Recipe]

    // MARK: - Initialization

    init(recipes: [Recipe] = [], favoriteRecipes: [Recipe] = []) {
        self.recipes = recipes
        self.favoriteRecipes = favoriteRecipes
    }

    // MARK: - Methods

    func isFavorite(recipe: Recipe) -> Bool {
        favoriteRecipes.contains { $0.name == recipe.name }
    }
}
