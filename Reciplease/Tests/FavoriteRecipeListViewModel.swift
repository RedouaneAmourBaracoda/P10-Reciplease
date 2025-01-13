//
//  FavoriteRecipeListViewModel.swift
//  RecipleaseTests
//
//  Created by Redouane on 13/01/2025.
//

@testable import Reciplease
import XCTest

@MainActor
final class FavoriteRecipeListViewModelTests: XCTestCase {

    var favoriteRecipeListViewModel: FavoriteRecipesListViewModel!

    var coreDataService: CoreDataStackMock!

    override func setUpWithError() throws {

        coreDataService = CoreDataStackMock()

        favoriteRecipeListViewModel = .init(coreDataService: coreDataService)
    }

    func testRefreshFavoriteStateFails() {
        // Given.

        // swiftlint:disable:next discouraged_direct_init
        let error = NSError()

        coreDataService.error = error

        // When.

        favoriteRecipeListViewModel.refreshRecipes()

        // Then.

        XCTAssertEqual(1, coreDataService.fetchRecipeCallsCounter)

        XCTAssertTrue(favoriteRecipeListViewModel.shouldPresentAlert)

        XCTAssertEqual(favoriteRecipeListViewModel.errorMessage, Localizable.undeterminedErrorDescription)
    }

    func testRefreshFavoriteStateSuccessWhenAddingNewRecipe() throws {
        // Given.

        let recipe: Recipe = .random()

        try coreDataService.add(newRecipe: recipe)

        // When.

        XCTAssertTrue(favoriteRecipeListViewModel.favoriteRecipes.isEmpty)

        favoriteRecipeListViewModel.refreshRecipes()

        // Then.

        XCTAssertTrue(favoriteRecipeListViewModel.favoriteRecipes.contains(recipe))

        XCTAssertEqual(1, coreDataService.fetchRecipeCallsCounter)

        XCTAssertFalse(favoriteRecipeListViewModel.shouldPresentAlert)

        XCTAssertTrue(favoriteRecipeListViewModel.errorMessage.isEmpty)
    }

    func testRefreshFavoriteStateSuccessWhenRemovingRecipe() throws {
        // Given.

        let recipe: Recipe = .random()

        try coreDataService.add(newRecipe: recipe)

        favoriteRecipeListViewModel.refreshRecipes()

        XCTAssertTrue(favoriteRecipeListViewModel.favoriteRecipes.contains(recipe))

        // When.

        try coreDataService.remove(recipe: recipe)

        favoriteRecipeListViewModel.refreshRecipes()

        // Then.

        XCTAssertTrue(favoriteRecipeListViewModel.favoriteRecipes.isEmpty)

        XCTAssertFalse(coreDataService.recipes.contains(recipe))

        XCTAssertEqual(1, coreDataService.removeRecipeCallsCounter)

        XCTAssertFalse(favoriteRecipeListViewModel.shouldPresentAlert)

        XCTAssertTrue(favoriteRecipeListViewModel.errorMessage.isEmpty)
    }
}
