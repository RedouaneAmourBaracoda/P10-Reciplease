//
//  FoodListView.swift
//  Reciplease
//
//  Created by Redouane on 25/11/2024.
//

import SwiftUI

struct FoodListView: View {

    @ObservedObject private var viewModel: SearchViewModel

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            headerView()
            listView()
            Spacer()
            searchActionView()
        }
        .background {
            CustomColors.main.ignoresSafeArea()
        }
    }

    private func headerView() -> some View {
        HStack {
            Text(Localizable.foodListTitle)
                .font(.custom(CustomFonts.body, size: 40.0))
                .foregroundStyle(.white)

            Spacer()

            Button(action: {
                viewModel.clear()
            }, label: {
                Text(Localizable.clearFoodListButtonTitle)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .background { Color.gray }
                    .clipShape(RoundedRectangle(cornerRadius: 5.0))
            })
        }
        .padding(.horizontal)
    }

    private func listView() -> some View {
        ScrollView {
            ForEach(viewModel.foodList, id: \.self) {
                Text("- \($0)")
                    .font(.custom(CustomFonts.body, size: 30.0))
                    .foregroundStyle(.white)
            }
        }
        .padding(.bottom)
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
                .padding()
                .background { CustomColors.secondary }
                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                .padding()
        }
    }
}

private extension Localizable {
    static let foodListTitle = NSLocalizedString(
        "search.food-list.title",
        comment: ""
    )

    static let clearFoodListButtonTitle = NSLocalizedString(
        "search.food-list.clear-button.title",
        comment: ""
    )

    static let searchForRecipesButtonTitle = NSLocalizedString(
        "search.food-list.button.title",
        comment: ""
    )
}

#Preview {
    FoodListView(viewModel: .init(foodList: ["Apple", "Tomatoes", "Curry", "Chicken"]))
}
