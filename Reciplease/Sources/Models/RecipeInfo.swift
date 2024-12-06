//
//  Recipes.swift
//  Reciplease
//
//  Created by Redouane on 03/12/2024.
//

import Foundation

struct RecipeInfo: Equatable, Hashable, Codable {
    let name: String
    let ingredients: [String]
    let servings: Int
    let time: Int
    let directions: [String]
    let imageURL: String
}
