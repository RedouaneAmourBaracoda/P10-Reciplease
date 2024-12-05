//
//  EdamamAPIResponse+Model.swift
//  Reciplease
//
//  Created by Redouane on 03/12/2024.
//

import Foundation

extension EdamamAPIResponse {
    var toRecipes: [RecipeModel] {
        hits.map {
            RecipeModel(
                name: $0.recipe.label,
                ingredients: $0.recipe.ingredients.map { $0.food },
                servings: Int($0.recipe.yield),
                time: Int($0.recipe.totalTime),
                directions: $0.recipe.ingredientLines,
                imageURL: $0.recipe.image
            )
        }
    }
}
