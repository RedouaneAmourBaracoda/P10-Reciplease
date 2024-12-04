//
//  RecipeModel+Preview.swift
//  Reciplease
//
//  Created by Redouane on 03/12/2024.
//

import Foundation

extension RecipeModel {
    static let forPreview = RecipeModel(
        name: "Lemon simple syrup",
        ingredients: ["sugar", "lemon", "zest"],
        servings: 4,
        time: 5,
        directions: ["- 2 cups sugar", "- Zest from 1 lemon", "- 3/4 cup fresh lemon juice"],
        imageURL: "https://www.splenda.com/wp-content/uploads/2020/09/lemon-simple-syrup-2000x1000.jpg"
    )
}
