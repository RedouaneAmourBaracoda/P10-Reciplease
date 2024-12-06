//
//  FavoriteRecipesRepository.swift
//  Reciplease
//
//  Created by Redouane on 06/12/2024.
//

import CoreData
import Foundation

struct FavoriteRecipesRepository {

    private let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack = .shared) {
        self.coreDataStack = coreDataStack
    }

    func add(newRecipe: RecipeInfo) throws {
        do {
            let dto = FavoriteRecipe(context: coreDataStack.context)
            dto.label = newRecipe.name
            dto.date = Date.now
            dto.data = try JSONEncoder().encode(newRecipe)
        } catch {
            print("Failed to encode recipe \(newRecipe.name) for repository.")
            throw FavoriteRecipesRepositoryError.encoding
        }

        do {
            try coreDataStack.context.save()
        } catch {
            print("Failed to save new recipe \(newRecipe.name) into repository")
            throw FavoriteRecipesRepositoryError.saving
        }
    }

    func fetch() throws -> [FavoriteRecipe]? {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        do {
            return try coreDataStack.context.fetch(request)
        } catch {
            print("Failed to retrieve recipes from data base")
            throw FavoriteRecipesRepositoryError.retrieving
        }
    }
}

enum FavoriteRecipesRepositoryError: LocalizedError {
    case encoding
    case saving
    case retrieving

    var errorDescription: String? {
        switch self {
        case .encoding:
            return "Failed to encode a new recipe for repository."
        case .saving:
            return "Failed to save a recipe into repository."
        case .retrieving:
            return "Failed to retrieve recipes from data base."
        }
    }
}
