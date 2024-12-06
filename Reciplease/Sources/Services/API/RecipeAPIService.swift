//
//  RecipeAPIService.swift
//  Reciplease
//
//  Created by Redouane on 24/11/2024.
//

import Foundation

protocol RecipeAPIService {
    func fetchRecipes(for food: String) async throws -> [Recipe]
}
