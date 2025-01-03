//
//  RecipeDetailViewModel.swift
//  Reciplease
//
//  Created by Redouane on 05/12/2024.
//

import SwiftUI

final class RecipeDetailViewModel: ObservableObject {

    // MARK: - Properties

    @Published var recipe: Recipe

    @Published var isFavorite: Bool

    @Published var shouldPresentAlert = false

    var errorMessage: String = ""

    // MARK: - Services

    private let repository: Repository

    // MARK: - Initialization

    init(recipe: Recipe, isFavorite: Bool = false, repository: Repository = Repository()) {
        self.recipe = recipe
        self.isFavorite = isFavorite
        self.repository = repository
    }

    // MARK: - Methods

    func addToFavorites() {
        do {
            try repository.add(newRecipe: recipe)
            isFavorite = true
        } catch {
            present(error: error)
        }
    }

    func removeFromFavorites() {
        do {
            try repository.remove(recipe: recipe)
            isFavorite = false
        } catch {
            present(error: error)
        }
    }

    private func present(error: Error) {
        if let repositoryError = error as? RepositoryError {
            NSLog(repositoryError.errorDescription ?? Localizable.undeterminedErrorDescription)
            errorMessage = repositoryError.userFriendlyDescription
        } else {
            NSLog(error.localizedDescription)
            errorMessage = Localizable.undeterminedErrorDescription
        }
        shouldPresentAlert = true
    }

    func refreshFavoriteState() {
        do {
            let favoriteRecipes = try repository.fetch()
            isFavorite = favoriteRecipes.contains(recipe)
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
