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

        searchViewModel.foodList = ["Cheese", "beef", "tomato"]

        // When.

        searchViewModel.clear()

        // Then.

        XCTAssertTrue(searchViewModel.foodList.isEmpty)
    }

    func testResetState() async {

        // Given.

        searchViewModel.foodList = ["Cheese", "beef", "tomato"]

        searchViewModel.showRecipes = true

        // When.

        searchViewModel.resetState()

        // Then.

        XCTAssertTrue(searchViewModel.foodList.isEmpty)

        XCTAssertFalse(searchViewModel.showRecipes)
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

        searchViewModel.inputFoodText = "Butter"

        // When.

        searchViewModel.add()

        // Then.

        XCTAssertTrue(searchViewModel.foodList.contains("Butter"))

        XCTAssertTrue(searchViewModel.inputFoodText.isEmpty)
    }

    func testAddWhenMultipleInputFood() async {

        // Given.

        searchViewModel.inputFoodText = "Butter"

        // When.

        searchViewModel.add()

        XCTAssertTrue(searchViewModel.inputFoodText.isEmpty)

        searchViewModel.inputFoodText = "Peanut"

        searchViewModel.add()

        XCTAssertTrue(searchViewModel.inputFoodText.isEmpty)

        searchViewModel.inputFoodText = "Bread"

        searchViewModel.add()

        XCTAssertTrue(searchViewModel.inputFoodText.isEmpty)

        // Then.

        XCTAssertEqual(searchViewModel.foodList, ["Butter", "Peanut", "Bread"])
    }

    func testGetRecipesWhenFoodListIsEmpty() async {

        // Given.

        searchViewModel.foodList = []

        // When.

        await searchViewModel.getRecipes()

        // Then.

        XCTAssertEqual(recipeAPIService.fetchRecipeCallsCounter, 0)

        XCTAssertTrue(searchViewModel.recipes.isEmpty)
    }

    func testGetRecipesWhenEdamammAPIReturnsError() async {

        // Given.

        searchViewModel.inputFoodText = "Butter"

        searchViewModel.add()

        XCTAssertTrue(searchViewModel.inputFoodText.isEmpty)

        XCTAssertTrue(searchViewModel.foodList.contains("Butter"))

        let error = EdamamAPIError.allCases.randomElement()

        recipeAPIService.error = error

        // When.

        await searchViewModel.getRecipes()

        // Then.

        XCTAssertEqual(recipeAPIService.fetchRecipeCallsCounter, 1)

        XCTAssertTrue(searchViewModel.shouldPresentAlert)

        XCTAssertEqual(searchViewModel.errorMessage, error?.userFriendlyDescription)

        XCTAssertTrue(searchViewModel.recipes.isEmpty)
    }

    func testGetRecipesWhenAPIReturnsOtherError() async {

        // Given.

        searchViewModel.inputFoodText = "Butter"

        searchViewModel.add()

        XCTAssertTrue(searchViewModel.inputFoodText.isEmpty)

        XCTAssertTrue(searchViewModel.foodList.contains("Butter"))

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
    }

    /*
    func testGetRecipesIsSuccessWhenNoErrors() async {
        // Given

        weatherViewModel.inputCityName = "Paris"

        let weather: Weather = .random()

        weatherAPIService.weatherToReturn = weather

        // When

        await weatherViewModel.getWeather()

        // Then

        XCTAssertEqual(weatherAPIService.fetchWeatherCallsCounter, 1)

        XCTAssertEqual(weatherViewModel.weather, weather)

        XCTAssertFalse(weatherViewModel.shouldPresentAlert)

        XCTAssertTrue(weatherViewModel.errorMessage.isEmpty)
    }
     */
}
