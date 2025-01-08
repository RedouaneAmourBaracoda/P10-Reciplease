//
//  RecipeDetailView.swift
//  Reciplease
//
//  Created by Redouane on 05/12/2024.
//

import SwiftUI

struct RecipeDetailView: View {

    @ObservedObject private var viewModel: RecipeDetailViewModel

    init(viewModel: RecipeDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            content()
                .customNavigationBar(navigationTitle: Localizable.navigationTitle)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text(Localizable.backButtonTitle).opacity(0)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.isFavorite ? viewModel.removeFromFavorites() : viewModel.addToFavorites()
                        } label: {
                            viewModel.isFavorite ? Image(systemName: "star.fill") : Image(systemName: "star")
                        }
                    }
                }
                .alert(isPresented: $viewModel.shouldPresentAlert) {
                    Alert(title: Text(Localizable.errorAlertTitle), message: Text(viewModel.errorMessage))
                }
                .background { CustomColors.main.ignoresSafeArea() }
                .onAppear { viewModel.refreshFavoriteState() }
        }
    }

    private func content() -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ImageView(recipe: viewModel.recipe, height: 300)
                ingredients()
                directionsButton()
                Spacer()
            }
        }
    }

    private func ingredients() -> some View {
        Group {
            Text(Localizable.ingredientsListTitle)
                .font(.custom(CustomFonts.body, size: 40))
            ForEach(viewModel.recipe.preparation.directions, id: \.self) { direction in
                Text("- \(direction)")
                    .font(.custom(CustomFonts.body, size: 25))
            }
        }
        .foregroundStyle(.white)
        .safeAreaPadding(.horizontal)
    }

    private func directionsButton() -> some View {
        HStack {
            Spacer()
            Button {

            } label: {
                Text(Localizable.getDirectionsButtonTitle)
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding(.vertical)
                    .padding(.horizontal, 80)
                    .background { CustomColors.secondary }
                    .clipShape(RoundedRectangle(cornerRadius: 5.0))
                    .padding()
            }
            Spacer()
        }
        .padding(.vertical)
    }
}

private extension Localizable {
    static let getDirectionsButtonTitle = NSLocalizedString(
        "recipe-detail.directions-button.title",
        comment: ""
    )

    static let ingredientsListTitle = NSLocalizedString(
        "recipe-detail.ingredients-list.title",
        comment: ""
    )
}

#Preview {
    RecipeDetailView(viewModel: .init(recipe: .raspberrySorbet))
}
