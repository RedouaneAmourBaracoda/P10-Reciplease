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

    private let coreDataService: CoreDataService

    // MARK: - Initialization

    init(coreDataService: CoreDataService = CoreDataStack.shared) {
        self.coreDataService = coreDataService
    }

    // MARK: - Methods

    func refreshRecipes() {
        do {
            favoriteRecipes = try coreDataService.fetch()
        } catch {
            errorMessage = Localizable.undeterminedErrorDescription
            shouldPresentAlert = true
        }
    }
}
