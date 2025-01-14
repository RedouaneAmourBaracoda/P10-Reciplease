//
//  ImageView.swift
//  Reciplease
//
//  Created by Redouane on 03/12/2024.
//

import Kingfisher
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
        ZStack {
            cachedImage()
                .accessibilityHidden(true)
            contentInfo()
        }
        .frame(height: imageHeight)
        .clipShape(.rect(cornerRadius: 1.0))
    }

    @MainActor
    private func cachedImage() -> some View {
        KFImage(URL(string: imageURL))
            .placeholder {
                ProgressView().progressViewStyle(.circular)
            }
            .onFailureImage(KFCrossPlatformImage(systemName: "xmark.circle"))
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxHeight: imageHeight)
    }

    private func contentInfo() -> some View {
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
            .background(.black.opacity(1/3))
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
                .foregroundStyle(.white)
            Text(ingredients)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.white.secondary)
        }
    }

    init(recipe: Recipe, height: CGFloat) {
        self.title = recipe.name
        self.ingredients = recipe.preparation.ingredients.joined(separator: ", ")
        self.servings = String(recipe.servings)
        self.time = recipe.readableTime
        self.imageURL = recipe.imageURL
        self.imageHeight = height
    }
}

private extension Recipe {
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

#Preview {
    ImageView(recipe: .raspberrySorbet, height: 200)
}
