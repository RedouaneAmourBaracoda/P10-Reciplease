//
//  FavoriteRecipesListViewModel.swift
//  Reciplease
//
//  Created by Redouane on 24/11/2024.
//

import SwiftUI

final class SearchResultRecipesListViewModel: ObservableObject {

    // MARK: - Properties

    let recipes: [Recipe]

    @Published var favoriteRecipes: [Recipe] = []

    @Published var shouldPresentAlert = false

    var errorMessage: String = ""

    // MARK: - Services

    private let repository: Repository

    // MARK: - Initialization

    init(recipes: [Recipe], repository: Repository = Repository()) {
        self.recipes = recipes
        self.repository = repository
    }

    // MARK: - Methods

    func refreshFavoriteRecipes() {
        do {
            favoriteRecipes = try repository.fetch()
        } catch {
            if let recipeAPIError = error as? (any RecipeAPIError) {
                NSLog(recipeAPIError.errorDescription ?? Localizable.undeterminedErrorDescription)
                errorMessage = recipeAPIError.userFriendlyDescription
            } else {
                errorMessage = Localizable.undeterminedErrorDescription
            }
            shouldPresentAlert = true
        }
    }
}
