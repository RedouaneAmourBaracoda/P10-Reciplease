//
//  EdamamAPIResponse+Model.swift
//  Reciplease
//
//  Created by Redouane on 03/12/2024.
//

import Foundation

extension EdamamAPIResponse {
    var toRecipes: [Recipe] {
        .init(
            hits.map {
                Recipe(
                    name: $0.recipe.label,
                    servings: Int($0.recipe.yield),
                    time: Int($0.recipe.totalTime),
                    imageURL: $0.recipe.image,
                    preparation: .init(
                        ingredients: $0.recipe.ingredients.map { $0.food },
                        directions: $0.recipe.ingredientLines
                    )
                )
            }
        )
    }
}
