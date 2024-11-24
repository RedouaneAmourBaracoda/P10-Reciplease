//
//  RecipeView.swift
//  Reciplease
//
//  Created by Redouane on 24/11/2024.
//

import SwiftUI

struct RecipeView: View {

    @ObservedObject private var viewModel = RecipeViewModel()

    var body: some View {
        Button {
            Task {
                await viewModel.getRecipe()
            }
        } label: {
            Text(Localizable.searchButtonTitle)
        }

    }
}

#Preview {
    RecipeView()
}
