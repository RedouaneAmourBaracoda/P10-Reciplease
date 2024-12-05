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
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.recipes, id: \.name) {
                    ImageView(recipe: $0, height: 200)
                }
            }
        }
    }
}

#Preview {
    RecipeListView(viewModel: .init(recipes: .forPreview))
}
