//
//  MockRecipeAPIService.swift
//  RecipleaseTests
//
//  Created by Redouane on 03/12/2024.
//

@testable import Reciplease
import Foundation

final class MockRecipeAPIService: RecipeAPIService {

    var recipesToReturn: [RecipeModel]!

    var error: Error?

    var fetchRecipeCallsCounter = 0

    func fetchRecipe(for food: String) async throws -> [RecipeModel] {
        fetchRecipeCallsCounter += 1

        guard let error else { return recipesToReturn }

        throw error
    }
}
