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
            VStack {
                InputFoodView(viewModel: viewModel)
                FoodListView(viewModel: viewModel)
            }
            .padding(.top)
            .padding(.bottom, 0.5)
            .customNavigationBar(navigationTitle: Localizable.navigationTitle)
        }
    }
}

private extension Localizable {
    static let navigationTitle = NSLocalizedString(
        "search.navigation.title",
        comment: ""
    )
}

#Preview {
    SearchView()
}
