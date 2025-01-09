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

    @Published var isFavorite: Bool = false

    @Published var shouldPresentAlert = false

    var errorMessage: String = ""

    // MARK: - Services

    private let coreDataService: CoreDataService

    // MARK: - Initialization

    init(recipe: Recipe, coreDataService: CoreDataService = CoreDataStack.shared) {
        self.recipe = recipe
        self.coreDataService = coreDataService
    }

    // MARK: - Methods

    func addToFavorites() {
        do {
            try coreDataService.add(newRecipe: recipe)
            isFavorite = true
        } catch {
            present(error: error)
        }
    }

    func removeFromFavorites() {
        do {
            try coreDataService.remove(recipe: recipe)
            isFavorite = false
        } catch {
            present(error: error)
        }
    }

    func refreshFavoriteState() {
        do {
            let favoriteRecipes = try coreDataService.fetch()
            isFavorite = favoriteRecipes.contains(recipe)
        } catch {
            present(error: error)
        }
    }

    private func present(error: Error) {
        errorMessage = Localizable.undeterminedErrorDescription
        shouldPresentAlert = true
    }
}
