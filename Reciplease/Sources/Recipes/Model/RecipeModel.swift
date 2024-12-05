//
//  RecipeModel.swift
//  Reciplease
//
//  Created by Redouane on 03/12/2024.
//

import Foundation

struct RecipeModel: Equatable, Hashable {
    let name: String
    let ingredients: [String]
    let servings: Int
    let time: Int
    let directions: [String]
    let imageURL: String
}
