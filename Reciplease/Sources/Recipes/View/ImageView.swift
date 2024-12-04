//
//  ImageView.swift
//  Reciplease
//
//  Created by Redouane on 03/12/2024.
//

import SwiftUI

struct ImageView: View {

    let recipe: RecipeModel

    let height: CGFloat

    var body: some View {
        RoundedRectangle(cornerRadius: 1.0)
            .stroke()
            .frame(height: height)
            .overlay {
                overlayContent()
            }
            .background { asyncImage() }
    }

    private func overlayContent() -> some View {
        VStack {
            HStack {
                Spacer()
                timeAndServingsInfo()
            }
            Spacer()
            HStack {
                titleInfo()
                Spacer()
            }
        }
        .safeAreaPadding()
    }

    private func timeAndServingsInfo() -> some View {
        Rectangle()
            .frame(width: 80, height: 60)
            .foregroundStyle(CustomColors.main)
            .border(.white, width: 2)
            .overlay {
                HStack(spacing: 10) {
                    VStack(spacing: 10) {
                        Text(String(recipe.servings))
                        Text(String(recipe.time) + "m")
                    }
                    .lineLimit(1)
                    VStack(spacing: 10) {
                        Image(systemName: "fork.knife.circle")
                        Image(systemName: "clock")
                    }
                }
                .foregroundStyle(.white)
            }
    }

    private func titleInfo() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(recipe.name)
                .font(.largeTitle)
                .fontWeight(.medium)
            Text(recipe.ingredients.joined(separator: ", "))
                .font(.title2)
                .fontWeight(.light)
        }
    }

    private func asyncImage() -> some View {
        AsyncImage(url: URL(string: recipe.imageURL)) {
            imageLoadingResult(phase: $0)
        }
    }

    @ViewBuilder
    private func imageLoadingResult(phase: AsyncImagePhase) -> some View {
        switch phase {
        case let .success(image):
            image.resizable()
        case let .failure(error):
            Text(Localizable.imageNotFound + " : " + error.localizedDescription)
        case .empty:
            ProgressView()
        @unknown default:
            Text(Localizable.undeterminedErrorDescription)
        }
    }
}

private extension Localizable {
    static let imageNotFound = NSLocalizedString(
        "recipe.image.not-found",
        comment: ""
    )
}

#Preview {
    ImageView(recipe: .forPreview, height: 200)
}
