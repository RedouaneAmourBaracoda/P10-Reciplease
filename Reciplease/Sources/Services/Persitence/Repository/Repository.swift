//
//  Repository.swift
//  Reciplease
//
//  Created by Redouane on 06/12/2024.
//

import CoreData
import Foundation

struct Repository {

    private let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack = .shared) {
        self.coreDataStack = coreDataStack
    }

    func add(newRecipe: Recipe) throws {
        do {
            let dto = FavoriteRecipe(context: coreDataStack.context)
            dto.name = newRecipe.name
            dto.servings = Int32(newRecipe.servings)
            dto.time = Int32(newRecipe.time)
            dto.imageURL = newRecipe.imageURL
            dto.data = try JSONEncoder().encode(newRecipe.preparation)
            print("\(newRecipe.name) was successfully encoded.")

            try coreDataStack.context.save()
            print("\(newRecipe.name) was successfully saved.")
        } catch {
            print("Failed to save new recipe \(newRecipe.name) into repository")
            NSLog(error.localizedDescription)
            throw RepositoryError.saving
        }
    }

    func fetch() throws -> [Recipe] {
        do {
            let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
            let favoriteRecipes = try coreDataStack.context.fetch(request)

            return try favoriteRecipes.compactMap {
                guard let name = $0.name, let imageURL = $0.imageURL, let data = $0.data else { return nil }
                let preparation = try JSONDecoder().decode(Recipe.Preparation.self, from: data)
                return Recipe(
                    name: name,
                    servings: Int($0.servings),
                    time: Int($0.time),
                    imageURL: imageURL,
                    preparation: preparation
                )
            }
        } catch {
            print("Failed to retrieve recipes from data base")
            throw RepositoryError.retrieving
        }
    }
}

enum RepositoryError: LocalizedError, CaseIterable {
    case saving
    case retrieving

    var errorDescription: String? {
        switch self {
        case .saving:
            return "Failed to save a recipe into repository."
        case .retrieving:
            return "Failed to retrieve recipes from data base."
        }
    }

    var userFriendlyDescription: String {
        switch self {
        case .saving:
            return "This recipe couldn't be saved. Please try again later."
        case .retrieving:
            return "Recipes couldn't be loaded. Please try again later."
        }
    }
}
