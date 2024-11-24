//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Redouane on 24/11/2024.
//

import XCTest
@testable import Reciplease

final class EdamamAPIServiceTests: XCTestCase {

    var recipeAPIService: EdamamAPIService!

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let sessionMock = URLSession(configuration: configuration)
        recipeAPIService = .init(session: sessionMock)
    }

    func testNetworkCallFailsWhenInvalidURL() async throws {
        recipeAPIService.urlString = ""
        try await testEdamamAPIError(statusCode: Int(), testedError: .invalidURL)
    }

    func testNetworkCallFailsWhenStatusCodeIs400() async throws {
        try await testEdamamAPIError(statusCode: 400, testedError: .badRequest)
    }

    func testNetworkCallFailsWhenStatusCodeIs401() async throws {
        try await testEdamamAPIError(statusCode: 401, testedError: .unauthorized)
    }

    func testNetworkCallFailsWhenStatusCodeIs404() async throws {
        try await testEdamamAPIError(statusCode: 404, testedError: .notFound)
    }

    func testNetworkCallFailsWhenStatusCodeIs429() async throws {
        try await testEdamamAPIError(statusCode: 429, testedError: .tooManyRequests)
    }

    func testNetworkCallFailsWhenStatusCodeIs5XX() async throws {
        try await testEdamamAPIError(statusCode: Int.random(in: 500...599), testedError: .internalError)
    }

    func testNetworkCallFailsWhenStatusCodeIsUnknown() async throws {
        try await testEdamamAPIError(
            statusCode: Set(-1000...1000)
                .subtracting(Set([200, 400, 401, 403, 404, 429]))
                .subtracting(Set(500...599))
                .randomElement() ?? 0,
            testedError: .invalidRequest
        )
    }

    // swiftlint:disable:next function_body_length
    func testNetworkCallSuccess() async throws {

        // When.

        MockURLProtocol.requestHandler = { request in
            XCTAssertNotNil(request.url)
            let mockResponse = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!

            let mockData = Data("""
                {
                    "q": "pea tomato bread",
                    "count": 1,
                    "hits": [
                        {
                            "recipe": {
                                "label": "Dinner Tonight: Amagansett Raw Corn, Tomato, and Snap Pea Salad Recipe",
                                "image": "",
                                "yield": 4.0,
                                "ingredientLines": [
                                    "8 ears fresh corn, stripped from the cob with a knife"
                                ],
                                "ingredients": [
                                    {
                                        "text": "8 ears fresh corn, stripped from the cob with a knife",
                                        "quantity": 8.0,
                                        "food": "fresh corn",
                                        "weight": 816.0,
                                        "foodCategory": "vegetables",
                                        "foodId": "",
                                        "image": ""
                                    }
                                ],
                                "calories": 1544.8940499999999,
                                "totalWeight": 2909.003159354124,
                                "totalTime": 15.0,
                                "cuisineType": [
                                    "south american"
                                ]
                            }
                        }
                    ]
                }
                """.utf8)
            return (mockResponse, mockData)
        }

        // Then.

        do {
            let actualResult = try await recipeAPIService.fetchRecipe(for: "")
            let expectedResult = EdamamAPIResponse(
                q: "pea tomato bread",
                count: 1,
                hits: [
                    Hit(
                        recipe:
                            Recipe(
                                label: "Dinner Tonight: Amagansett Raw Corn, Tomato, and Snap Pea Salad Recipe",
                                image: "",
                                yield: 4.0,
                                ingredientLines: [
                                    "8 ears fresh corn, stripped from the cob with a knife"
                                ],
                                ingredients: [
                                    Ingredient(
                                        text: "8 ears fresh corn, stripped from the cob with a knife",
                                        quantity: 8.0,
                                        food: "fresh corn",
                                        weight: 816.0,
                                        foodCategory: "vegetables",
                                        foodId: "",
                                        image: ""
                                    )
                                ],
                                calories: 1544.8940499999999,
                                totalWeight: 2909.003159354124,
                                totalTime: 15.0,
                                cuisineType: ["south american"]
                            )
                    )
                ]
            )

            XCTAssertEqual(actualResult, expectedResult)
        } catch {
            XCTAssertNil(error)
        }
    }

    private func testEdamamAPIError(statusCode: Int, testedError: EdamamAPIError) async throws {

        MockURLProtocol.requestHandler = { request in
            XCTAssertNotNil(request.url)
            let mockResponse = HTTPURLResponse(
                url: request.url!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            )!

            let mockData = Data()
            return (mockResponse, mockData)
        }

        // Then.

        do {
            _ = try await recipeAPIService.fetchRecipe(for: "")
        } catch let error as EdamamAPIError {
            XCTAssertTrue(error == testedError)
            XCTAssertEqual(error.errorDescription, testedError.errorDescription)
            XCTAssertEqual(error.userFriendlyDescription, testedError.userFriendlyDescription)
        }
    }
}

private extension Localizable {
    static let chicken = NSLocalizedString(
        "unit-tests.edamam-api.food.chicken",
        comment: ""
    )
}
