//
//  RecipeListViewModel.swift
//  Reciplease
//
//  Created by Redouane on 03/12/2024.
//

import SwiftUI

@MainActor
final class RecipeListViewModel: ObservableObject {

    // MARK: - State

    @Published var recipes: [RecipeInfo]

    init(recipes: [RecipeInfo]) {
        self.recipes = recipes
    }
}
