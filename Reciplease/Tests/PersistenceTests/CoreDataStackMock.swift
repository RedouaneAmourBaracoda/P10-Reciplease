//
//  CoreDataStackMock.swift
//  RecipleaseTests
//
//  Created by Redouane on 09/01/2025.
//

@testable import Reciplease
import Foundation

final class CoreDataStackMock: CoreDataService {

    var recipes: [Recipe] = []

    var error: Error?

    var addRecipeCallsCounter = 0

    var removeRecipeCallsCounter = 0

    var fetchRecipeCallsCounter = 0

    func add(newRecipe: Recipe) throws {
        addRecipeCallsCounter += 1

        recipes.append(newRecipe)

        guard let error else { return }

        throw error
    }

    func remove(recipe: Recipe) throws {
        removeRecipeCallsCounter += 1

        recipes.removeAll { $0 == recipe }

        guard let error else { return }

        throw error
    }

    func fetch() throws -> [Recipe] {
        fetchRecipeCallsCounter += 1

        guard let error else { return recipes }

        throw error
    }
}
