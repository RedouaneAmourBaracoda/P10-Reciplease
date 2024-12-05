//
//  RecipeView.swift
//  Reciplease
//
//  Created by Redouane on 05/12/2024.
//

import SwiftUI

struct RecipeView: View {

    let recipe: RecipeModel

    var body: some View {
        NavigationStack {
            content()
                .customNavigationBar(navigationTitle: Localizable.navigationTitle)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Back").opacity(0)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.white)
                    }
                }
                .background {
                    CustomColors.main.ignoresSafeArea()
                }
        }
    }

    private func content() -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ImageView(recipe: recipe, height: 300)
                ingredients()
                directionsButton()
                Spacer()
            }
        }
    }

    private func ingredients() -> some View {
        Group {
            Text("Ingredients")
                .font(.custom(CustomFonts.body, size: 40))
            ForEach(recipe.directions, id: \.self) { direction in
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
                Text("Get directions")
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

#Preview {
    RecipeView(recipe: .raspberrySorbet)
}
