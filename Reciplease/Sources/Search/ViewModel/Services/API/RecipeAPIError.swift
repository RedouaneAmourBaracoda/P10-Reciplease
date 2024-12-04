//
//  RecipeAPIError.swift
//  Reciplease
//
//  Created by Redouane on 24/11/2024.
//

import Foundation

protocol RecipeAPIError: LocalizedError, CaseIterable {
    var errorDescription: String { get }

    var userFriendlyDescription: String { get }
}
