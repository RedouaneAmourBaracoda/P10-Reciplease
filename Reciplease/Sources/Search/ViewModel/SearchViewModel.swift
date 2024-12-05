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

    @Published var recipes: [RecipeModel] = []

    @Published var showRecipes = false

    @Published var inputFoodText: String = ""

    @Published var foodList: [String]

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

    func getRecipes() async {

        guard !foodList.isEmpty else { return }

        let food = foodList.joined(separator: " ")

        do {
            let list = try await recipeAPIService.fetchRecipes(for: food)
            recipes = Array(Set(list))
            showRecipes = true
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
