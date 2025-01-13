//
//  SearchViewModelTests.swift
//  RecipleaseTests
//
//  Created by Redouane on 03/12/2024.
//

@testable import Reciplease
import XCTest

@MainActor
final class SearchViewModelTests: XCTestCase {

    var searchViewModel: SearchViewModel!

    var recipeAPIService: MockRecipeAPIService!

    override func setUpWithError() throws {

        recipeAPIService = MockRecipeAPIService()

        searchViewModel = .init(recipeAPIService: recipeAPIService)
    }

    func testClear() async {

        // Given.

        searchViewModel.foodList = .random()

        // When.

        searchViewModel.clear()

        // Then.

        XCTAssertTrue(searchViewModel.foodList.isEmpty)
    }

    func testResetState() async {

        // Given.

        searchViewModel.foodList = .random()

        searchViewModel.showRecipes = true

        searchViewModel.searchInProgress = true

        // When.

        searchViewModel.resetState()

        // Then.

        XCTAssertTrue(searchViewModel.foodList.isEmpty)

        XCTAssertFalse(searchViewModel.showRecipes)

        XCTAssertFalse(searchViewModel.searchInProgress)
    }

    func testAddWhenInputFoodIsEmpty() async {

        // Given.

        searchViewModel.inputFoodText = ""

        // When.

        searchViewModel.add()

        // Then.

        XCTAssertTrue(searchViewModel.foodList.isEmpty)
    }

    func testAddWhenInputFoodIsNotEmpty() async {

        // Given.
        let food: String = .random()
        searchViewModel.inputFoodText = food

        // When.

        searchViewModel.add()

        // Then.

        XCTAssertTrue(searchViewModel.foodList.contains(food))

        XCTAssertTrue(searchViewModel.inputFoodText.isEmpty)
    }

    func testAddWithFood() async {

        // Given.

        let food: [String] = .random()

        food.forEach {

            // When.

            searchViewModel.inputFoodText = $0

            searchViewModel.add()

            XCTAssertTrue(searchViewModel.inputFoodText.isEmpty)
        }

        // Then.

        XCTAssertEqual(searchViewModel.foodList, food.filter { !$0.isEmpty })
    }

    func testButtonIsDisabledWhenFoodListIsEmpty() async {

        // Given.

        searchViewModel.foodList = []

        // Then.

        XCTAssertTrue(searchViewModel.isSearchButtonDisabled)
    }

    func testSearchButtonIsEnabledWhenFoodListIsNotEmpty() async {

        // Given.

        searchViewModel.inputFoodText = .random()

        searchViewModel.add()

        // Then.

        XCTAssertFalse(searchViewModel.isSearchButtonDisabled)
    }

    func testSearchButtonIsDisabledWhenFoodListIsNotEmptyAndSearchIsInProgress() async {

        // Given.

        let food: String = .random()

        searchViewModel.inputFoodText = food

        searchViewModel.add()

        XCTAssertFalse(searchViewModel.isSearchButtonDisabled)

        // When.

        searchViewModel.searchInProgress = true

        // Then.

        XCTAssertTrue(searchViewModel.isSearchButtonDisabled)
    }

    func testGetRecipesWhenEdamamAPIReturnsError() async {

        // Given.

        let food: String = .random()

        searchViewModel.inputFoodText = food

        searchViewModel.add()

        XCTAssertTrue(searchViewModel.inputFoodText.isEmpty)

        XCTAssertTrue(searchViewModel.foodList.contains(food))

        XCTAssertFalse(searchViewModel.searchInProgress)

        XCTAssertFalse(searchViewModel.isSearchButtonDisabled)

        let error = EdamamAPIError.allCases.randomElement()

        recipeAPIService.error = error

        // When.

        await searchViewModel.getRecipes()

        // Then.

        XCTAssertEqual(recipeAPIService.fetchRecipeCallsCounter, 1)

        XCTAssertTrue(searchViewModel.shouldPresentAlert)

        XCTAssertEqual(searchViewModel.errorMessage, error?.userFriendlyDescription)

        XCTAssertTrue(searchViewModel.recipes.isEmpty)

        XCTAssertFalse(searchViewModel.searchInProgress)

        XCTAssertTrue(searchViewModel.foodList.isEmpty)

        XCTAssertTrue(searchViewModel.isSearchButtonDisabled)
    }

    func testGetRecipesWhenAPIReturnsOtherError() async {

        // Given.

        let food: String = .random()

        searchViewModel.inputFoodText = food

        searchViewModel.add()

        XCTAssertTrue(searchViewModel.inputFoodText.isEmpty)

        XCTAssertTrue(searchViewModel.foodList.contains(food))

        XCTAssertFalse(searchViewModel.searchInProgress)

        XCTAssertFalse(searchViewModel.isSearchButtonDisabled)

        // swiftlint:disable:next discouraged_direct_init
        let error = NSError()

        recipeAPIService.error = error

        // When.

        await searchViewModel.getRecipes()

        // Then.

        XCTAssertEqual(recipeAPIService.fetchRecipeCallsCounter, 1)

        XCTAssertTrue(searchViewModel.shouldPresentAlert)

        XCTAssertEqual(searchViewModel.errorMessage, Localizable.undeterminedErrorDescription)

        XCTAssertTrue(searchViewModel.recipes.isEmpty)

        XCTAssertFalse(searchViewModel.searchInProgress)

        XCTAssertTrue(searchViewModel.foodList.isEmpty)

        XCTAssertTrue(searchViewModel.isSearchButtonDisabled)
    }

    func testGetRecipesIsSuccessWhenNoErrors() async {

        // Given.

        let expectedRecipes: [Recipe] = .random()

        recipeAPIService.recipesToReturn = expectedRecipes

        // When.

        await searchViewModel.getRecipes()

        // Then.

        XCTAssertEqual(recipeAPIService.fetchRecipeCallsCounter, 1)

        XCTAssertEqual(searchViewModel.recipes, expectedRecipes)

        XCTAssertTrue(searchViewModel.showRecipes)

        XCTAssertFalse(searchViewModel.shouldPresentAlert)

        XCTAssertTrue(searchViewModel.errorMessage.isEmpty)

        XCTAssertFalse(searchViewModel.searchInProgress)

        XCTAssertTrue(searchViewModel.isSearchButtonDisabled)
    }
}
