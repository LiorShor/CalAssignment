//
//  RecipesRepository.swift
//  CalAssignment
//
//  Created by Lior Shor on 22/11/2024.
//

import Foundation
import Combine

protocol RecipesRepositoryProtocol {
    func fetchRecipes() -> AnyPublisher<[Recipe], Error>
}

struct RecipesRepository: RecipesRepositoryProtocol {
    let recipeService: RecipeServiceProtocol

    func fetchRecipes() -> AnyPublisher<[Recipe], any Error> {
        recipeService.fetchRecipes()
            .map { recipes in
                return recipes // in case we want to do filtering.
            }
            .catch { error -> AnyPublisher<[Recipe], Error> in
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
