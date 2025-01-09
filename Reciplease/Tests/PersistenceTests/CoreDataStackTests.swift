//
//  CoreDataStackTests.swift
//  RecipleaseTests
//
//  Created by Redouane on 08/01/2025.
//

@testable import Reciplease
import CoreData
import XCTest

final class CoreDataStackTests: XCTestCase {

    var coreDataStack: CoreDataStack!

    override func setUpWithError() throws {
        let description = NSPersistentStoreDescription()

        description.url = URL(fileURLWithPath: "/dev/null")

        let container = NSPersistentContainer(name: NSPersistentContainer.PersistentKeys.persitentContainerName)

        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        coreDataStack = CoreDataStack(persistentContainer: container)
    }

    func testFetchRecipes() throws {
        // Given.

        let recipe1 = FavoriteRecipe(context: coreDataStack.context)

        let recipe2 = FavoriteRecipe(context: coreDataStack.context)

        let recipe3 = FavoriteRecipe(context: coreDataStack.context)

        // When.

        try coreDataStack.context.save()

        // Then.

        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()

        let recipes = try coreDataStack.context.fetch(request)

        XCTAssertEqual(3, recipes.count)

        XCTAssertTrue(recipes.contains(recipe1))

        XCTAssertTrue(recipes.contains(recipe2))

        XCTAssertTrue(recipes.contains(recipe3))
    }

    func testRemoveRecipes() throws {
        // Given.

        let recipe1 = FavoriteRecipe(context: coreDataStack.context)

        let recipe2 = FavoriteRecipe(context: coreDataStack.context)

        let recipe3 = FavoriteRecipe(context: coreDataStack.context)

        // When.

        try coreDataStack.context.save()

        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()

        let recipes = try coreDataStack.context.fetch(request)

        recipes.forEach { coreDataStack.context.delete($0) }

        try coreDataStack.context.save()

        let finalRecipes = try coreDataStack.context.fetch(request)

        // Then.

        XCTAssertEqual(0, finalRecipes.count)

        XCTAssertFalse(finalRecipes.contains(recipe1))

        XCTAssertFalse(finalRecipes.contains(recipe2))

        XCTAssertFalse(finalRecipes.contains(recipe3))
    }
}
