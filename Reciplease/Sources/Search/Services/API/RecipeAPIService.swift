//
//  RecipeAPIService.swift
//  Reciplease
//
//  Created by Redouane on 24/11/2024.
//

import Foundation

protocol RecipeAPIService {
    func fetchRecipe(for food: String) async throws -> EdamamAPIResponse
}
