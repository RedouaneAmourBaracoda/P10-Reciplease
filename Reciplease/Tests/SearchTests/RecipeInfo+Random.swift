//
//  RecipeInfo+Random.swift
//  Reciplease
//
//  Created by Redouane on 05/12/2024.
//

import Foundation

extension Array<RecipeInfo> {
    static func random(length: Int = .random(in: 0...10)) -> [RecipeInfo] {
        [Int](repeating: 1, count: length).map { _ in RecipeInfo.random() }
    }
}

extension RecipeInfo {
    static func random() -> RecipeInfo {
        RecipeInfo(
            name: .random(),
            ingredients: .random(),
            servings: .random(in: 0...100),
            time: .random(in: 0...1200),
            directions: .random(),
            imageURL: .random()
        )
    }
}

extension Array<String> {
    static func random(length: Int = .random(in: 0...100)) -> [String] {
        [Int](repeating: 1, count: length).map { _ in String.random() }
    }
}

extension String {
    static func random(length: Int = .random(in: 0...100)) -> String {
        String((0..<length).map { _ in letters.randomElement() ?? " " })
    }

    private static let letters = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
}
