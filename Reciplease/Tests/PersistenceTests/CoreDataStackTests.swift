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

    func testSaveRecipes() throws {
        // Given.

        let recipe: Recipe = .random()

        // When.

        try coreDataStack.add(newRecipe: recipe)

        // Then.

        let recipes = try coreDataStack.fetch()

        XCTAssertEqual(1, recipes.count)

        XCTAssertTrue(recipes.contains(recipe))
    }

    func testRemoveRecipes() throws {
        // Given.

        let recipe1: Recipe = .random()

        let recipe2: Recipe = .random()

        // When.

        try coreDataStack.add(newRecipe: recipe1)

        try coreDataStack.add(newRecipe: recipe2)

        let recipes = try coreDataStack.fetch()

        XCTAssertEqual(2, recipes.count)

        XCTAssertTrue(recipes.contains(recipe1))

        XCTAssertTrue(recipes.contains(recipe2))

        try coreDataStack.remove(recipe: recipe1)

        try coreDataStack.remove(recipe: recipe2)

        let finalRecipes = try coreDataStack.fetch()

        // Then.

        XCTAssertEqual(0, finalRecipes.count)

        XCTAssertFalse(finalRecipes.contains(recipe1))

        XCTAssertFalse(finalRecipes.contains(recipe2))
    }
}
