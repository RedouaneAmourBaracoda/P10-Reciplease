//
//  RecipeDetailViewModel.swift
//  RecipleaseTests
//
//  Created by Redouane on 09/01/2025.
//

@testable import Reciplease
import XCTest

@MainActor
final class RecipeDetailViewModelTests: XCTestCase {

    var recipeDetailViewModel: RecipeDetailViewModel!

    var coreDataService: CoreDataStackMock!

    override func setUpWithError() throws {

        coreDataService = CoreDataStackMock()

        recipeDetailViewModel = .init(recipe: .random(), coreDataService: coreDataService)
    }

    func testAddToFavoritesFails() {
        // Given.

        // swiftlint:disable:next discouraged_direct_init
        let error = NSError()

        coreDataService.error = error

        // When.

        XCTAssertTrue(coreDataService.recipes.isEmpty)

        recipeDetailViewModel.addToFavorites()

        // Then.

        XCTAssertTrue(coreDataService.recipes.isEmpty)

        XCTAssertEqual(1, coreDataService.addRecipeCallsCounter)

        XCTAssertTrue(recipeDetailViewModel.shouldPresentAlert)

        XCTAssertEqual(recipeDetailViewModel.errorMessage, Localizable.undeterminedErrorDescription)
    }

    func testAddToFavoritesSuccess() {
        // Given.

        let recipe: Recipe = .random()

        recipeDetailViewModel.recipe = recipe

        // When.

        XCTAssertTrue(coreDataService.recipes.isEmpty)

        recipeDetailViewModel.addToFavorites()

        // Then.

        XCTAssertTrue(coreDataService.recipes.contains(recipe))

        XCTAssertEqual(1, coreDataService.addRecipeCallsCounter)

        XCTAssertFalse(recipeDetailViewModel.shouldPresentAlert)

        XCTAssertTrue(recipeDetailViewModel.errorMessage.isEmpty)
    }

    func testRefreshFavoriteStateFails() {
        // Given.

        // swiftlint:disable:next discouraged_direct_init
        let error = NSError()

        coreDataService.error = error

        // When.

        recipeDetailViewModel.refreshFavoriteState()

        // Then.

        XCTAssertEqual(1, coreDataService.fetchRecipeCallsCounter)

        XCTAssertTrue(recipeDetailViewModel.shouldPresentAlert)

        XCTAssertEqual(recipeDetailViewModel.errorMessage, Localizable.undeterminedErrorDescription)

        XCTAssertTrue(coreDataService.recipes.isEmpty)

        XCTAssertFalse(recipeDetailViewModel.isFavorite)
    }

    func testRefreshFavoriteStateSuccess() throws {
        // Given.

        let recipe: Recipe = .random()

        recipeDetailViewModel.recipe = recipe

        try coreDataService.add(newRecipe: recipe)

        // When.

        XCTAssertFalse(recipeDetailViewModel.isFavorite)

        recipeDetailViewModel.refreshFavoriteState()

        // Then.

        XCTAssertTrue(recipeDetailViewModel.isFavorite)

        XCTAssertEqual(1, coreDataService.fetchRecipeCallsCounter)

        XCTAssertFalse(recipeDetailViewModel.shouldPresentAlert)

        XCTAssertTrue(recipeDetailViewModel.errorMessage.isEmpty)
    }

    func testRemoveFromFavoritesFails() {
        // Given.

        // swiftlint:disable:next discouraged_direct_init
        let error = NSError()

        coreDataService.error = error

        // When.

        recipeDetailViewModel.removeFromFavorites()

        // Then.

        XCTAssertEqual(1, coreDataService.removeRecipeCallsCounter)

        XCTAssertTrue(recipeDetailViewModel.shouldPresentAlert)

        XCTAssertEqual(recipeDetailViewModel.errorMessage, Localizable.undeterminedErrorDescription)
    }

    func testRemoveFromFavoritesSuccess() {
        // Given.

        let recipe: Recipe = .random()

        recipeDetailViewModel.recipe = recipe

        recipeDetailViewModel.addToFavorites()

        recipeDetailViewModel.refreshFavoriteState()

        XCTAssertTrue(recipeDetailViewModel.isFavorite)

        // When.

        recipeDetailViewModel.removeFromFavorites()

        recipeDetailViewModel.refreshFavoriteState()

        // Then.

        XCTAssertFalse(recipeDetailViewModel.isFavorite)

        XCTAssertFalse(coreDataService.recipes.contains(recipe))

        XCTAssertEqual(1, coreDataService.removeRecipeCallsCounter)

        XCTAssertFalse(recipeDetailViewModel.shouldPresentAlert)

        XCTAssertTrue(recipeDetailViewModel.errorMessage.isEmpty)
    }
}
