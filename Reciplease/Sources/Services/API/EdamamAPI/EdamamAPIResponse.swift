//
//  EdamamAPIResponse.swift
//  Reciplease
//
//  Created by Redouane on 24/11/2024.
//

import Foundation

// swiftlint:disable identifier_name
struct EdamamAPIResponse: Codable, Equatable {
    let q: String
    let count: Int
    let hits: [Hit]
}
// swiftlint:enable identifier_name

struct Hit: Codable, Equatable {
    let recipe: RecipeInfo
}

struct RecipeInfo: Codable, Equatable {
    let label: String
    let image: String
    let yield: Float
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let totalTime: Float
}

struct Ingredient: Codable, Equatable {
    let text: String
    let quantity: Float
    let food: String
}
