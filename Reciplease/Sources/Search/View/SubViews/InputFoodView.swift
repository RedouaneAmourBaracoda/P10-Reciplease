//
//  InputFoodView.swift
//  Reciplease
//
//  Created by Redouane on 25/11/2024.
//

import SwiftUI

struct InputFoodView: View {

    @ObservedObject private var viewModel: SearchViewModel

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 8.0) {
            Text(Localizable.searchFoodTitle)
                .font(.title2)
                .foregroundStyle(CustomColors.main)
            HStack(spacing: 8) {
                VStack {
                    TextField(Localizable.searchFoodPlaceholder, text: $viewModel.inputFoodText)
                        .fontWeight(.bold)
                        .autocorrectionDisabled()
                    Divider()
                }
                Button {
                    viewModel.add()
                } label: {
                    Text(Localizable.addFoodButtonTitle)
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .background { Color.green }
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                }
            }
            .padding()
        }
    }
}

private extension Localizable {
    static let searchFoodTitle = NSLocalizedString(
        "search.food.textfield.title",
        comment: ""
    )

    static let searchFoodPlaceholder = NSLocalizedString(
        "search.food.textfield.placeholder",
        comment: ""
    )

    static let addFoodButtonTitle = NSLocalizedString(
        "search.food.add-button.title",
        comment: ""
    )
}

#Preview {
    InputFoodView(viewModel: .init())
}
