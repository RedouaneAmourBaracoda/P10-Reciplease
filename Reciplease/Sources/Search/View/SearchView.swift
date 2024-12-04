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
            contentView()
                .customNavigationBar(navigationTitle: Localizable.navigationTitle)
                .alert(isPresented: $viewModel.shouldPresentAlert) {
                    Alert(title: Text(Localizable.errorAlertTitle), message: Text(viewModel.errorMessage))
                }
        }
    }

    private func contentView() -> some View {
        VStack {
            InputFoodView(viewModel: viewModel)
            FoodListView(viewModel: viewModel)
        }
        .padding(.top)
        .padding(.bottom, 0.5)
    }
}

private extension Localizable {
    static let navigationTitle = NSLocalizedString(
        "search.navigation.title",
        comment: ""
    )

    static let errorAlertTitle = NSLocalizedString(
        "search.alert.error.title",
        comment: ""
    )
}

#Preview {
    SearchView()
}
