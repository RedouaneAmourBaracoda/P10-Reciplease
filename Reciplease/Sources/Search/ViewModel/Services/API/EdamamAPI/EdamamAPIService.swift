//
//  EdamamAPIService.swift
//  Reciplease
//
//  Created by Redouane on 24/11/2024.
//

import Foundation

struct EdamamAPIService: RecipeAPIService {

    // MARK: - API infos.

    private enum APIInfos {

        static let ressource = "https://api.edamam.com/search?"

        static let appId = "56918294"

        static let appKey = "4b369722603a033a39878f50aae05330"

        static let url = ressource + "app_id=" + appId + "&app_key=" + appKey + "&q="
    }

    // MARK: - Properties.

    var urlString = APIInfos.url

    private var session: URLSession

    // MARK: - Dependency injection.

    init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - Methods.

    func fetchRecipes(for food: String) async throws -> [RecipeModel] {

        guard let url = URL(string: urlString + food) else { throw EdamamAPIError.invalidURL }

        let request = URLRequest(url: url)

        let (data, response) = try await session.data(for: request)

        let result = EdamamAPIError.checkStatusCode(urlResponse: response)

        switch result {

        case .success:

            return try JSONDecoder()
                .decode(EdamamAPIResponse.self, from: data)
                .toRecipes

        case let .failure(failure):

            throw failure
        }
    }
}
