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
        NavigationStack {
            content()
                .customNavigationBar(navigationTitle: Localizable.navigationTitle)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Back").opacity(0)
                    }
                }
        }
    }

    private func content() -> some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.recipes, id: \.name) { recipe in
                    NavigationLink {
                        RecipeView(recipe: recipe)
                    } label: {
                        ImageView(recipe: recipe, height: 200)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    RecipeListView(viewModel: .init(recipes: .forPreview))
}
