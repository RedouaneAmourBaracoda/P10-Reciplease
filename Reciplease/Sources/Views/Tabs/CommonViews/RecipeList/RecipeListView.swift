//
//  RecipeListView.swift
//  Reciplease
//
//  Created by Redouane on 03/12/2024.
//

import SwiftUI

struct RecipeListView: View {

    @ObservedObject private var viewModel: RecipeListViewModel

    init(viewModel: RecipeListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.recipes, id: \.name) { recipe in
                    NavigationLink {
                        RecipeDetailView(
                            viewModel: .init(
                                recipe: recipe,
                                isFavorite: viewModel.isFavorite(recipe: recipe)
                            )
                        )
                    } label: {
                        ImageView(recipe: recipe, height: 200)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

extension Recipe {
    static let lemonSimpleSyrup = Recipe(
        name: "Lemon simple syrup",
        servings: 4,
        time: 5,
        imageURL: "https://www.splenda.com/wp-content/uploads/2020/09/lemon-simple-syrup-2000x1000.jpg",
        preparation: .init(
            ingredients: ["sugar", "lemon", "zest"],
            directions: ["2 cups sugar", "Zest from 1 lemon", "3/4 cup fresh lemon juice"]
        )
    )

    static let orangeSherbetBombe = Recipe(
        name: "Orange sherbet bombe",
        servings: 12,
        time: 8,
        imageURL: "https://amagicalmess.com/wp-content/uploads/2020/12/orange-sherbet-punch-123.jpg",
        preparation: .init(
            ingredients: ["orange sherbet", "vanilla ice cream"],
            directions: ["1/2 quarts orange sherbet", "1/2 quarts vanilla ice cream"]
        )
    )

    static let raspberrySorbet = Recipe(
        name: "Raspberry sorbet",
        servings: 10,
        time: 6,
        imageURL: "https://www.biggerbolderbaking.com/wp-content/uploads/2016/04/IMG_0692.jpg",
        preparation: .init(
            ingredients: ["raspberries", "sugar", "lemon juice"],
            directions: ["½ pints raspberries", "¼ cups sugar", "1 teaspoon fresh lemon juice"]
        )
    )
}

extension Array<Recipe> {
    static let forPreview: [Recipe] = [.lemonSimpleSyrup, .orangeSherbetBombe, .raspberrySorbet]
}

#Preview {
    RecipeListView(
        viewModel: .init(
            recipes: [.raspberrySorbet, .lemonSimpleSyrup, .orangeSherbetBombe],
            favoriteRecipes: [.lemonSimpleSyrup]
        )
    )
}
