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
                .background { CustomColors.main.ignoresSafeArea() }
        }
    }

    private func contentView() -> some View {
        VStack {
            InputFoodView(viewModel: viewModel)
            FoodListView(viewModel: viewModel)
            Spacer()
            searchActionView()
                .navigationDestination(isPresented: $viewModel.showRecipes) {
                    RecipeListView(viewModel: .init(recipes: viewModel.recipes))
                }
        }
        .onAppear { viewModel.resetState() }
        .padding(.top)
        .padding(.bottom, 0.5)
    }

    private func searchActionView() -> some View {
        Button {
            Task {
                await viewModel.getRecipes()
            }
        } label: {
            Text(Localizable.searchForRecipesButtonTitle)
                .font(.title2)
                .foregroundStyle(.white)
                .padding(.vertical)
                .padding(.horizontal, 80)
                .background { CustomColors.secondary }
                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                .padding()
        }
    }
}

extension Localizable {
    static let navigationTitle = NSLocalizedString(
        "search.navigation.title",
        comment: ""
    )

    static let errorAlertTitle = NSLocalizedString(
        "search.alert.error.title",
        comment: ""
    )

    static let searchForRecipesButtonTitle = NSLocalizedString(
        "search.food-list.button.title",
        comment: ""
    )
}

#Preview {
    SearchView()
}
