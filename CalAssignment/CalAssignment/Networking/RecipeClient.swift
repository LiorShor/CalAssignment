//
//  RecipeClient.swift
//  CalAssignment
//
//  Created by Lior Shor on 23/11/2024.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badUrl
    case noData
}

protocol RecipeServicable: AnyObject {
    func fetchRecipes() -> AnyPublisher<[Recipe], Error>
}

class RecipeClient: RecipeServicable {
    
    func fetchRecipes() -> AnyPublisher<[Recipe], Error> {
        let urlString: String = "https://hf-android-app.s3-eu-west-1.amazonaws.com/android-test/recipes.json"
        
        guard let url = URL(string: urlString) else { return Fail(error: NetworkError.badUrl).eraseToAnyPublisher() }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Recipe].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .catch { error -> AnyPublisher<[Recipe], Error> in
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
