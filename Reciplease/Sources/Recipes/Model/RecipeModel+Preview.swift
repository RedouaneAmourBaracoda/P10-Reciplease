//
//  RecipeModel+Preview.swift
//  Reciplease
//
//  Created by Redouane on 03/12/2024.
//

import Foundation

extension RecipeModel {
    static let lemonSimpleSyrup = RecipeModel(
        name: "Lemon simple syrup",
        ingredients: ["sugar", "lemon", "zest"],
        servings: 4,
        time: 5,
        directions: ["- 2 cups sugar", "- Zest from 1 lemon", "- 3/4 cup fresh lemon juice"],
        imageURL: "https://www.splenda.com/wp-content/uploads/2020/09/lemon-simple-syrup-2000x1000.jpg"
    )

    static let orangeSherbetBombe = RecipeModel(
        name: "Orange sherbet bombe",
        ingredients: ["orange sherbet", "vanilla ice cream"],
        servings: 12,
        time: 8,
        directions: ["- 1/2 quarts orange sherbet", "- 1/2 quarts vanilla ice cream"],
        imageURL: "https://amagicalmess.com/wp-content/uploads/2020/12/orange-sherbet-punch-123.jpg"
    )

    static let raspberrySorbet = RecipeModel(
        name: "Raspberry sorbet",
        ingredients: ["raspberries", "sugar", "lemon juice"],
        servings: 10,
        time: 6,
        directions: ["- ½ pints raspberries", "- ¼ cups sugar", "teaspoon fresh lemon juice"],
        imageURL: "https://www.biggerbolderbaking.com/wp-content/uploads/2016/04/IMG_0692.jpg"
    )
}

extension Array<RecipeModel> {
    static let forPreview: Self = [
        .lemonSimpleSyrup,
        .orangeSherbetBombe,
        .raspberrySorbet
    ]
}
