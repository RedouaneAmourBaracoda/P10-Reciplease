//
//  RecipeListViewModel.swift
//  Reciplease
//
//  Created by Redouane on 03/12/2024.
//

import SwiftUI

@MainActor
final class RecipeListViewModel: ObservableObject {

    // MARK: - Properties

    @Published var recipes: [Recipe]

    @Published var favoriteRecipes: [Recipe] = []

    @Published var shouldPresentAlert = false

    var errorMessage: String = ""

    // MARK: - Services

    private let repository: Repository

    // MARK: - Initialization

    init(recipes: [Recipe] = [], repository: Repository = Repository()) {
        self.recipes = recipes
        self.repository = repository
    }

    // MARK: - Methods

    func getFavoriteRecipes() {
        do {
            favoriteRecipes = try repository.fetch()
        } catch {
            if let repositoryError = error as? RepositoryError {
                NSLog(repositoryError.errorDescription ?? Localizable.undeterminedErrorDescription)
                errorMessage = repositoryError.userFriendlyDescription
            } else {
                errorMessage = Localizable.undeterminedErrorDescription
            }
            shouldPresentAlert = true
        }
    }

    func isFavorite(recipe: Recipe) -> Bool {
        favoriteRecipes.contains { $0.name == recipe.name }
    }
}
