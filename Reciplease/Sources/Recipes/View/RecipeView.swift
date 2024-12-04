//
//  RecipeView.swift
//  Reciplease
//
//  Created by Redouane on 03/12/2024.
//

import SwiftUI

struct RecipeView: View {

    private let recipe: RecipeModel

    init(recipe: RecipeModel) {
        self.recipe = recipe
    }

    var body: some View {
        VStack {
            ImageView(recipe: recipe, height: 300)
            Spacer()
        }
    }
}

#Preview {
    RecipeView(recipe: .forPreview)
}
