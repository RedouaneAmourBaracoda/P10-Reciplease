//
//  RecipeViewModel.swift
//  Reciplease
//
//  Created by Redouane on 24/11/2024.
//

import SwiftUI

@MainActor
final class SearchViewModel: ObservableObject {

    // MARK: - State

    @Published var recipes: [RecipeInfo] = []

    @Published var searchInProgress = false

    @Published var showRecipes = false

    @Published var inputFoodText: String = ""

    @Published var foodList: [String] = []

    @Published var shouldPresentAlert = false

    var isSearchButtonDisabled: Bool {
        searchInProgress || foodList.isEmpty
    }

    var errorMessage: String = ""

    // MARK: - Services.

    private let recipeAPIService: RecipeAPIService

    // MARK: - Initializer.

    init(recipeAPIService: RecipeAPIService = EdamamAPIService(), foodList: [String] = []) {
        self.recipeAPIService = recipeAPIService
        self.foodList = foodList
    }

    // MARK: - Methods.

    func add() {
        guard !inputFoodText.isEmpty else { return }
        foodList.append(inputFoodText)
        inputFoodText.removeAll()
    }

    func clear() {
        foodList.removeAll()
    }

    func getRecipes() async {

        let food = foodList.joined(separator: " ")

        searchInProgress = true

        do {
            recipes = try await recipeAPIService.fetchRecipes(for: food)
            searchInProgress = false
            showRecipes = true
        } catch {
            if let recipeAPIError = error as? (any RecipeAPIError) {
                NSLog(recipeAPIError.errorDescription ?? Localizable.undeterminedErrorDescription)
                errorMessage = recipeAPIError.userFriendlyDescription
            } else {
                errorMessage = Localizable.undeterminedErrorDescription
            }
            shouldPresentAlert = true
            resetState()
        }
    }

    func resetState() {
        searchInProgress = false
        showRecipes = false
        foodList.removeAll()
    }
}
