//
//  SearchResultRecipesListView.swift
//  Reciplease
//
//  Created by Redouane on 02/01/2025.
//

import SwiftUI

struct SearchResultRecipesListView: View {
    @ObservedObject private var viewModel: SearchResultRecipesListViewModel

    init(viewModel: SearchResultRecipesListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            RecipeListView(viewModel: .init(recipes: viewModel.recipes))
                .customNavigationBar(navigationTitle: Localizable.recipeListNavigationTitle)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text(Localizable.backButtonTitle).opacity(0)
                            .accessibilityLabel(Localizable.backButtonTitle)
                    }
                }
        }
    }
}

extension Localizable {
    static let recipeListNavigationTitle = NSLocalizedString(
        "search.result-list.screen-title",
        comment: ""
    )
}

#Preview {
    SearchResultRecipesListView(viewModel: .init(recipes: [.lemonSimpleSyrup, .raspberrySorbet, .orangeSherbetBombe]))
}
