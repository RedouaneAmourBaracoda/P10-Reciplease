//
//  ImageView.swift
//  Reciplease
//
//  Created by Redouane on 03/12/2024.
//

import SwiftUI

struct ImageView: View {

    let title: String

    let ingredients: String

    let servings: String

    let time: String

    let imageURL: String

    let imageHeight: CGFloat

    init(title: String, ingredients: String, servings: String, time: String, imageURL: String, imageHeight: CGFloat) {
        self.title = title
        self.ingredients = ingredients
        self.servings = servings
        self.time = time
        self.imageURL = imageURL
        self.imageHeight = imageHeight
    }

    var body: some View {
        RoundedRectangle(cornerRadius: 1.0)
            .stroke()
            .frame(height: imageHeight)
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
        HStack(spacing: 10) {
            VStack(spacing: 10) {
                Text(servings)
                Text(time)
            }
            .lineLimit(1)
            VStack(spacing: 10) {
                Image(systemName: "fork.knife.circle")
                Image(systemName: "clock")
            }
        }
        .foregroundStyle(.white)
        .frame(width: 70, height: 60)
        .background {
            Rectangle()
                .foregroundStyle(CustomColors.main)
                .border(.white)
        }
    }

    private func titleInfo() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title)
                .fontWeight(.medium)
            Text(ingredients)
                .font(.title3)
                .fontWeight(.light)
        }
    }

    private func asyncImage() -> some View {
        AsyncImage(url: URL(string: imageURL)) {
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

    init(recipe: RecipeInfo, height: CGFloat) {
        self.title = recipe.name
        self.ingredients = recipe.ingredients.joined(separator: ", ")
        self.servings = String(recipe.servings)
        self.time = recipe.readableTime
        self.imageURL = recipe.imageURL
        self.imageHeight = height
    }
}

private extension RecipeInfo {
    var readableTime: String {

        guard time > 0 else { return "-"}

        let totalSeconds = time * 60

        let (hours, minutes) = (totalSeconds / 3600, (totalSeconds % 3600) / 60)

        let hoursString = hours == 0 ? "" : "~" + String(hours) + "h"

        let minutesString = minutes == 0 ? "" : String(minutes) + "m"

        let output = hoursString.isEmpty ? minutesString : hoursString

        return output
    }
}

private extension Localizable {
    static let imageNotFound = NSLocalizedString(
        "recipe.image.not-found",
        comment: ""
    )
}

#Preview {
    ImageView(recipe: .raspberrySorbet, height: 200)
}
