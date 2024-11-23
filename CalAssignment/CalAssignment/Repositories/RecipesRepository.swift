//
//  RecipesRepository.swift
//  CalAssignment
//
//  Created by Lior Shor on 22/11/2024.
//

import Foundation
import Combine

protocol RecipesRepositoriable: AnyObject {
    func fetchRecipes() -> AnyPublisher<[Recipe], Error>
}

class RecipesRepository: RecipesRepositoriable {
    var recipeService: RecipeServicable?

    init(recipeService: RecipeServicable? = nil) {
        self.recipeService = recipeService
    }
    
    func fetchRecipes() -> AnyPublisher<[Recipe], any Error> {
        guard let recipeService else {
            return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
        return recipeService.fetchRecipes()
            .map { recipes in
                return recipes // in case we want to do filtering.
            }
            .catch { error -> AnyPublisher<[Recipe], Error> in
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
