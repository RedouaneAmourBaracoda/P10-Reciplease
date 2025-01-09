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
