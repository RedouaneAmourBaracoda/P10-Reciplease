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
            print("\(newRecipe.name) was successfully added.")
        } catch {
            print("Failed to add new recipe \(newRecipe.name) into repository")
            NSLog(error.localizedDescription)
            throw RepositoryError.adding
        }
    }

    func remove(recipe: Recipe) throws {
        do {
            let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
            request.predicate = NSPredicate(format: "name = %@", recipe.name)
            let favoriteRecipes = try coreDataStack.context.fetch(request)
            for favoriteRecipe in favoriteRecipes where favoriteRecipe.name == recipe.name {
                coreDataStack.context.delete(favoriteRecipe)
            }
            try coreDataStack.context.save()
            print("\(recipe.name) was successfully removed.")
        } catch {
            print("Failed to remove recipe \(recipe.name) from repository")
            NSLog(error.localizedDescription)
            throw RepositoryError.removing
        }
    }

    func fetch() throws -> [Recipe] {
        do {
            let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
            let favoriteRecipes = try coreDataStack.context.fetch(request)

            return try favoriteRecipes.compactMap {
                guard
                    let name = $0.name,
                    let imageURL = $0.imageURL,
                    let data = $0.data
                else {
                    print("Failed to load one recipe into repository")
                    throw RepositoryError.retrieving
                }

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
    case adding
    case removing
    case retrieving

    var errorDescription: String? {
        switch self {
        case .adding:
            return "Failed to save a favorite recipe into repository."
        case .retrieving:
            return "Failed to retrieve favorite recipes from data base."
        case .removing:
            return "Failed to remove favorite recipes from data base."
        }
    }

    var userFriendlyDescription: String {
        switch self {
        case .adding:
            return "This recipe couldn't be saved as favorite. Please try again later."
        case .retrieving:
            return "Favorite recipes couldn't be loaded. Please try again later."
        case .removing:
            return "Favorite recipe couldn't be removed from data base. Please try again later."
        }
    }
}
