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
            RecipeListView(viewModel: .init(recipes: viewModel.recipes, favoriteRecipes: viewModel.favoriteRecipes))
                .customNavigationBar(navigationTitle: Localizable.navigationTitle)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Back").opacity(0)
                    }
                }
                .alert(isPresented: $viewModel.shouldPresentAlert) {
                    Alert(title: Text(Localizable.errorAlertTitle), message: Text(viewModel.errorMessage))
                }
                .onAppear { viewModel.refreshFavoriteRecipes() }
        }
    }
}

#Preview {
    SearchResultRecipesListView(viewModel: .init(recipes: [.lemonSimpleSyrup, .raspberrySorbet, .orangeSherbetBombe]))
}
