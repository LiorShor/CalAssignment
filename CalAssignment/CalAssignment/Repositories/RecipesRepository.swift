//
//  RecipesRepository.swift
//  CalAssignment
//
//  Created by Lior Shor on 22/11/2024.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badUrl
    case noData
}

struct RecipesRepository {
    
    func fetchRecipes() -> AnyPublisher<[Recipe], Error> {
        let urlString: String = "https://hf-android-app.s3-eu-west-1.amazonaws.com/android-test/recipes.json"
        guard let url = URL(string: urlString) else { return Fail(error: NetworkError.badUrl).eraseToAnyPublisher() }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Recipe], decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .catch { error -> AnyPublisher<[Recipe], Error> in
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
