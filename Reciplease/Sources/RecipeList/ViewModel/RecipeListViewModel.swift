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

    @Published var recipes: [Recipe]

    init(recipes: [Recipe]) {
        self.recipes = recipes
    }
}
