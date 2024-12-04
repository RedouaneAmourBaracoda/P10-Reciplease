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
    let recipe: Recipe
}

struct Recipe: Codable, Equatable {
    let label: String
    let image: String
    let yield: Int
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories: Double
    let totalWeight: Double
    let totalTime: Int
    let cuisineType: [String]
}

struct Ingredient: Codable, Equatable {
    let text: String
    let quantity: Float
    let food: String
    let weight: Double
    let foodCategory: String
    let foodId: String
    let image: String
}
