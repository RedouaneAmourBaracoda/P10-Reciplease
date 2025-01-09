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

    private let coreDataStack: CoreDataStack

    // MARK: - Initialization

    init(coreDataStack: CoreDataStack = .shared) {
        self.coreDataStack = coreDataStack
    }

    // MARK: - Methods

    func refreshRecipes() {
        do {
            favoriteRecipes = try coreDataStack.fetch()
        } catch {
            NSLog(error.localizedDescription)
            errorMessage = Localizable.undeterminedErrorDescription
            shouldPresentAlert = true
        }
    }
}
