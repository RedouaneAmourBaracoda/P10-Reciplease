//
//  FavoriteRecipesListViewModel.swift
//  Reciplease
//
//  Created by Redouane on 24/11/2024.
//

import SwiftUI

final class SearchResultRecipesListViewModel: ObservableObject {

    // MARK: - Properties

    let recipes: [Recipe]

    // MARK: - Initialization

    init(recipes: [Recipe]) {
        self.recipes = recipes
    }
}
