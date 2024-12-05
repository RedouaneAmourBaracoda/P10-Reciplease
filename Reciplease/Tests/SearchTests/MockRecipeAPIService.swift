//
//  MockRecipeAPIService.swift
//  RecipleaseTests
//
//  Created by Redouane on 03/12/2024.
//

@testable import Reciplease
import Foundation

final class MockRecipeAPIService: RecipeAPIService {

    var recipesToReturn: [RecipeInfo]!

    var error: Error?

    var fetchRecipeCallsCounter = 0

    func fetchRecipes(for food: String) async throws -> [RecipeInfo] {
        fetchRecipeCallsCounter += 1

        guard let error else { return recipesToReturn }

        throw error
    }
}
