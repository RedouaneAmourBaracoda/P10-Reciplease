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
            Text("What's in your fridge ?")
            HStack(spacing: 8) {
                TextField("Lemon, Cheese, Sausages...", text: $viewModel.inputFoodText)
                    .fontWeight(.bold)
                    .autocorrectionDisabled()
                Button {

                } label: {
                    Text("Add")
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .background {
                            Color.green
                        }
                }
            }
            .padding()
        }
    }
}

#Preview {
    InputFoodView(viewModel: .init())
}
