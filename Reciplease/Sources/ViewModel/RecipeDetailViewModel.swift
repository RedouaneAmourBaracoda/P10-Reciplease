//
//  RecipeDetailViewModel.swift
//  Reciplease
//
//  Created by Redouane on 05/12/2024.
//

import SwiftUI

@MainActor
final class RecipeDetailViewModel: ObservableObject {

    // MARK: - State

    @Published var recipe: Recipe

    @Published var saveInProgress = false

    @Published var shouldPresentAlert = false

    var errorMessage: String = ""

    // MARK: - Services

    private let repository: Repository

    // MARK: - Initialization

    init(recipe: Recipe, repository: Repository = Repository()) {
        self.recipe = recipe
        self.repository = repository
    }

    // MARK: - Methods

    func addToFavorites() {
        do {
            try repository.add(newRecipe: recipe)
        } catch {
            present(error: error)
        }
    }

    func retrieveFavorites() {
        do {
            let recipes = try repository.fetch()
            print("Favorites recipes :")
            print("")
            recipes.forEach {
                print($0.name)
                print("")
            }
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
}
