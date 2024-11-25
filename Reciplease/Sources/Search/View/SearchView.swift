//
//  RecipeView.swift
//  Reciplease
//
//  Created by Redouane on 24/11/2024.
//

import SwiftUI

struct SearchView: View {

    @ObservedObject private var viewModel: SearchViewModel = .init()

    var body: some View {
        NavigationStack {
            ScrollView {
                InputFoodView(viewModel: viewModel)
                Spacer()
            }
            .safeAreaPadding()
            .customNavigationBar(navigationTitle: "Reciplease")
        }
    }
}

#Preview {
    SearchView()
}
