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

    private let coreDataStack: CoreDataService

    // MARK: - Initialization

    init(recipe: Recipe, isFavorite: Bool = false, coreDataStack: CoreDataService = CoreDataStack.shared) {
        self.recipe = recipe
        self.isFavorite = isFavorite
        self.coreDataStack = coreDataStack
    }

    // MARK: - Methods

    func addToFavorites() {
        do {
            try coreDataStack.add(newRecipe: recipe)
            isFavorite = true
        } catch {
            present(error: error)
        }
    }

    func removeFromFavorites() {
        do {
            try coreDataStack.remove(recipe: recipe)
            isFavorite = false
        } catch {
            present(error: error)
        }
    }

    func refreshFavoriteState() {
        do {
            let favoriteRecipes = try coreDataStack.fetch()
            isFavorite = favoriteRecipes.contains(recipe)
        } catch {
            present(error: error)
        }
    }

    private func present(error: Error) {
        NSLog(error.localizedDescription)
        errorMessage = Localizable.undeterminedErrorDescription
        shouldPresentAlert = true
    }
}
