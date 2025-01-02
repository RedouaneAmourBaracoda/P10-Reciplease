//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Redouane on 06/12/2024.
//

import CoreData
import Foundation

final class CoreDataStack {

    // MARK: Properties

    private enum PersistentKeys {
        static let persitentContainerName = "FavoriteRecipes"
    }

    // MARK: Singleton

    static let shared = CoreDataStack()

    private init() {}

    // MARK: Public

    var context: NSManagedObjectContext { persitentContainer.viewContext }

    // MARK: Private

    private lazy var persitentContainer: NSPersistentContainer = {
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
