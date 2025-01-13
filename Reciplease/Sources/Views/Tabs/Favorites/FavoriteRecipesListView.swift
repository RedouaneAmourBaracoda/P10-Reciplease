//
//  FavoriteRecipesListView.swift
//  Reciplease
//
//  Created by Redouane on 02/01/2025.
//

import SwiftUI

struct FavoriteRecipesListView: View {
    @ObservedObject private var viewModel = FavoriteRecipesListViewModel()

    var body: some View {
        NavigationStack {
            conditionalList()
                .customNavigationBar(navigationTitle: Localizable.navigationTitle)
                .alert(isPresented: $viewModel.shouldPresentAlert) {
                    Alert(title: Text(Localizable.errorAlertTitle), message: Text(viewModel.errorMessage))
                }
                .onAppear { viewModel.refreshRecipes() }
        }
    }

    @ViewBuilder
    private func conditionalList() -> some View {
        if viewModel.favoriteRecipes.isEmpty {
            Text(Localizable.emptyListMessage)
                .padding()
        } else {
            RecipeListView(viewModel: .init(recipes: viewModel.favoriteRecipes))
        }
    }
}

private extension Localizable {
    static let emptyListMessage = NSLocalizedString(
        "favorite-recipes.empty-list.message",
        comment: ""
    )
}

#Preview {
    FavoriteRecipesListView()
}
