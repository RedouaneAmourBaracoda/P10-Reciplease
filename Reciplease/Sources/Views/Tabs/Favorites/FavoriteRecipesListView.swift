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
            RecipeListView(viewModel: .init(recipes: viewModel.favoriteRecipes))
                .customNavigationBar(navigationTitle: Localizable.navigationTitle)
                .alert(isPresented: $viewModel.shouldPresentAlert) {
                    Alert(title: Text(Localizable.errorAlertTitle), message: Text(viewModel.errorMessage))
                }
                .onAppear { viewModel.refreshRecipes() }
        }
    }
}

#Preview {
    FavoriteRecipesListView()
}
