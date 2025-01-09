//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Redouane on 06/12/2024.
//

import CoreData
import Foundation

final class CoreDataStack {
    var persistentContainer: NSPersistentContainer

    var context: NSManagedObjectContext { persistentContainer.viewContext }

    init(persistentContainer: NSPersistentContainer = .FavoriteRecipesContainer) {
        self.persistentContainer = persistentContainer
    }

    static let shared: CoreDataStack = CoreDataStack()

    func add(newRecipe: Recipe) throws {
        let dto = FavoriteRecipe(context: context)
        dto.name = newRecipe.name
        dto.servings = Int32(newRecipe.servings)
        dto.time = Int32(newRecipe.time)
        dto.imageURL = newRecipe.imageURL
        dto.data = try JSONEncoder().encode(newRecipe.preparation)
        print("\(newRecipe.name) was successfully encoded.")

        try context.save()
        print("\(newRecipe.name) was successfully added.")
    }

    func remove(recipe: Recipe) throws {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", recipe.name)
        let favoriteRecipes = try context.fetch(request)
        for favoriteRecipe in favoriteRecipes where favoriteRecipe.name == recipe.name {
            context.delete(favoriteRecipe)
        }
        try context.save()
        print("\(recipe.name) was successfully removed.")
    }

    func fetch() throws -> [Recipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        let favoriteRecipes = try context.fetch(request)

        return try favoriteRecipes.compactMap {
            guard
                let name = $0.name,
                let imageURL = $0.imageURL,
                let data = $0.data
            else {
                print("Failed to load one recipe into Database")
                return nil
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
    }
}

extension NSPersistentContainer {
    enum PersistentKeys {
        static let persitentContainerName = "FavoriteRecipes"
    }

    static let FavoriteRecipesContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: PersistentKeys.persitentContainerName)
        container.loadPersistentStores { storeDescription, error in

            print("Loading store \(storeDescription.description) ...")
            if let error = error as? NSError {
                fatalError("Found error while loading persistent store : \(error.userInfo)")
            }

            print("Successfully loaded store : \(storeDescription.description)")
        }
        return container
    }()
}
