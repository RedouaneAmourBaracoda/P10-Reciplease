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
/*
    func testNoFetchWhenInputCityNameIsEmpty() async {

        // Given.

        weatherViewModel.inputCityName = ""

        // When.

        await weatherViewModel.getWeather()

        // Then.

        XCTAssertEqual(weatherAPIService.fetchWeatherCallsCounter, 0)

        XCTAssertNil(weatherViewModel.weather)
    }

    func testGetWeatherWhenOpenWeatherAPIReturnsError() async {

        // Given.

        weatherViewModel.inputCityName = "Paris"

        let error = OpenWeatherAPIError.allCases.randomElement()

        weatherAPIService.error = error

        // When.

        await weatherViewModel.getWeather()

        // Then.

        XCTAssertEqual(weatherAPIService.fetchWeatherCallsCounter, 1)

        XCTAssertTrue(weatherViewModel.shouldPresentAlert)

        XCTAssertEqual(weatherViewModel.errorMessage, error?.userFriendlyDescription)

        XCTAssertNil(weatherViewModel.weather)
    }

    // Testing when the WeatherAPI returns a random error.
    func testGetWeatherWhenAPIReturnsOtherError() async {

        // Given.

        weatherViewModel.inputCityName = "Paris"

        // swiftlint:disable:next discouraged_direct_init
        let error = NSError()

        weatherAPIService.error = error

        // When.

        await weatherViewModel.getWeather()

        // Then.

        XCTAssertEqual(weatherAPIService.fetchWeatherCallsCounter, 1)

        XCTAssertTrue(weatherViewModel.shouldPresentAlert)

        XCTAssertEqual(weatherViewModel.errorMessage, Localizable.Weather.undeterminedErrorDescription)

        XCTAssertNil(weatherViewModel.weather)
    }

    func testGetWeatherIsSuccessWhenNoErrors() async {

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
