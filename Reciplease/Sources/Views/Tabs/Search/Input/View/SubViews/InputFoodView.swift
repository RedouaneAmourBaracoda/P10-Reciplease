//
//  InputFoodView.swift
//  Reciplease
//
//  Created by Redouane on 25/11/2024.
//

import SwiftUI

struct InputFoodView: View {

    @ObservedObject private var viewModel: SearchViewModel

    @FocusState private var showKeyboard: Bool

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Text(Localizable.searchFoodTitle)
                .font(.title2)
                .foregroundStyle(CustomColors.main)
            HStack(spacing: 8) {
                VStack {
                    TextField(Localizable.searchFoodPlaceholder, text: $viewModel.inputFoodText)
                        .foregroundStyle(.black)
                        .fontWeight(.bold)
                        .autocorrectionDisabled()
                        .focused($showKeyboard)
                        .accessibilityLabel(Localizable.textFieldAccessibilityLabel)
                        .accessibilityHint(Localizable.textFieldAccessibilityHint)
                    Divider()
                }
                Button {
                    showKeyboard = false
                    viewModel.add()
                } label: {
                    Text(Localizable.addFoodButtonTitle)
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .background { CustomColors.secondary }
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                }
                .accessibilityHint(Localizable.addFoodButtonAccessibilityHint)
            }
            .padding(.horizontal)
        }
        .padding()
        .background {
            Color.white
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

    static let textFieldAccessibilityLabel = NSLocalizedString(
        "search.food.textfield.accessibility-label",
        comment: ""
    )

    static let textFieldAccessibilityHint = NSLocalizedString(
        "search.food.textfield.accessibility-hint",
        comment: ""
    )

    static let addFoodButtonAccessibilityHint = NSLocalizedString(
        "search.food.add-button.accessibility-hint",
        comment: ""
    )
}

#Preview {
    InputFoodView(viewModel: .init())
}
