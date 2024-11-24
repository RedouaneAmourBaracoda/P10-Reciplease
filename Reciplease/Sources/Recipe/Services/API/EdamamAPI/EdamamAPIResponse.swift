//
//  EdamamAPIResponse.swift
//  Reciplease
//
//  Created by Redouane on 24/11/2024.
//

import Foundation

// swiftlint:disable identifier_name
struct EdamamAPIResponse: Codable {
    let q: String
    let count: Int
    let hits: [Hit]
}
// swiftlint:enable identifier_name

struct Hit: Codable {
    let recipe: Recipe
}

struct Recipe: Codable {
    let label: String
    let image: String
    let yield: Float
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories: Double
    let totalWeight: Double
    let totalTime: Float
    let cuisineType: [String]
}

struct Ingredient: Codable {
    let text: String
    let quantity: Float
    let food: String
    let weight: Double
    let foodCategory: String
    let foodId: String
    let image: String
}
