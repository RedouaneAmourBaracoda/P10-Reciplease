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
                .customNavigationBar(navigationTitle: Localizable.recipeDetailScreenNavigatioTitle)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text(Localizable.backButtonTitle).opacity(0)
                            .accessibilityLabel(Localizable.backButtonTitle)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.isFavorite ? viewModel.removeFromFavorites() : viewModel.addToFavorites()
                        } label: {
                            viewModel.isFavorite ? Image(systemName: "star.fill") : Image(systemName: "star")
                        }
                        .accessibilityValue(
                            viewModel.isFavorite ? Localizable.favoriteButtonActivated
                            : Localizable.favoriteButtonDeactivated
                        )
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
                Spacer()
            }
        }
    }

    private func ingredients() -> some View {
        Group {
            Text(Localizable.ingredientsListTitle)
                .font(.custom(CustomFonts.body, size: 40))
                .accessibilityAddTraits(.isHeader)
            ForEach(viewModel.recipe.preparation.directions, id: \.self) { direction in
                Text("- \(direction)")
                    .font(.custom(CustomFonts.body, size: 25))
            }
        }
        .foregroundStyle(.white)
        .safeAreaPadding(.horizontal)
        .accessibilityElement(children: .contain)
    }
}

extension Localizable {
    static let recipeDetailScreenNavigatioTitle = NSLocalizedString(
        "recipe-detail.navigation-title",
        comment: ""
    )

    static let ingredientsListTitle = NSLocalizedString(
        "recipe-detail.ingredients-list.title",
        comment: ""
    )

    static let recipeDetailTitleAccessibilityLabel = NSLocalizedString(
        "recipe-detail.title.accessibility-label",
        comment: ""
    )

    static let recipeDetailListAccessibilityLabel = NSLocalizedString(
        "recipe-detail.ingredients.accessibility-label",
        comment: ""
    )

    static let recipeDetailTimingAccessibilityLabel = NSLocalizedString(
        "recipe-detail.timing.accessibility-label",
        comment: ""
    )

    static let recipeDetailServingsAccessibilityLabel = NSLocalizedString(
        "recipe-detail.servings.accessibility-label",
        comment: ""
    )

    static let favoriteButtonActivated = NSLocalizedString(
        "recipe-detail.favorite-button.activated",
        comment: ""
    )

    static let favoriteButtonDeactivated = NSLocalizedString(
        "recipe-detail.favorite-button.deactivated",
        comment: ""
    )
}

#Preview {
    RecipeDetailView(viewModel: .init(recipe: .raspberrySorbet))
}
