//
//  RecipeDetailViewModel.swift
//  Reciplease
//
//  Created by Redouane on 05/12/2024.
//

import SwiftUI

@MainActor
final class RecipeDetailViewModel: ObservableObject {

    // MARK: - State

    @Published var recipe: RecipeInfo

    init(recipe: RecipeInfo) {
        self.recipe = recipe
    }
}
