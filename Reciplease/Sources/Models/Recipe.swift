//
//  Recipes.swift
//  Reciplease
//
//  Created by Redouane on 03/12/2024.
//

import Foundation

struct Recipe: Codable {
    let name: String
    let servings: Int
    let time: Int
    let imageURL: String
    let preparation: Preparation

    struct Preparation: Codable {
        let ingredients: [String]
        let directions: [String]
    }
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.name == rhs.name
    }
}
