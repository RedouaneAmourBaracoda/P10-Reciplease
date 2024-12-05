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

    @Published var recipes: [RecipeModel] = []

    init(recipes: [RecipeModel]) {
        self.recipes = recipes
    }
}
