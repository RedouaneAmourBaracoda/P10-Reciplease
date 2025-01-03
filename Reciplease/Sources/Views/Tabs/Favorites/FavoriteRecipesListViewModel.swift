//
//  FavoriteRecipesListViewModel.swift
//  Reciplease
//
//  Created by Redouane on 24/11/2024.
//

import SwiftUI

final class FavoriteRecipesListViewModel: ObservableObject {

    // MARK: - Properties

    @Published var favoriteRecipes: [Recipe] = []

    @Published var shouldPresentAlert = false

    var errorMessage: String = ""

    // MARK: - Services

    private let repository: Repository

    // MARK: - Initialization

    init(repository: Repository = Repository()) {
        self.repository = repository
    }

    // MARK: - Methods

    func refreshRecipes() {
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
