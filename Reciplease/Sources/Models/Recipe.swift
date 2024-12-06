//
//  Recipes.swift
//  Reciplease
//
//  Created by Redouane on 03/12/2024.
//

import Foundation

struct Recipe: Equatable, Hashable, Codable {
    let name: String
    let servings: Int
    let time: Int
    let imageURL: String
    let preparation: Preparation

    struct Preparation: Equatable, Hashable, Codable {
        let ingredients: [String]
        let directions: [String]
    }
}
