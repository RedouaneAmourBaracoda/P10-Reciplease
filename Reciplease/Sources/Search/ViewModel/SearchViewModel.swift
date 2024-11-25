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

    @Published var inputFoodText: String = ""

    @Published var foodList: [String]

    @Published var recipe: String = "chicken"

    @Published var shouldPresentAlert = false

    var errorMessage: String = ""

    // MARK: - Services.

    private let recipeAPIService: EdamamAPIService

    // MARK: - Initializer.

    init(recipeAPIService: EdamamAPIService = EdamamAPIService(), foodList: [String] = []) {
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

    func getRecipe() async {

        guard !recipe.isEmpty else { return }

        do {
            let apiResponse = try await recipeAPIService.fetchRecipe(for: recipe)
            print(apiResponse)
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
