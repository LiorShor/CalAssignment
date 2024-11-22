//
//  RecipesViewModel.swift
//  CalAssignment
//
//  Created by Lior Shor on 22/11/2024.
//

import Foundation
import Combine

class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    private let repository: RecipesRepository
    private var cancellables: Set<AnyCancellable> = []
    
    init(repository: RecipesRepository) {
        self.repository = repository
        fetchRecipes()
    }
    
    private func fetchRecipes() {
        repository.fetchRecipes()
            .sink { _ in
                
            } receiveValue: { recipes in
                self.recipes = recipes
            }.store(in: &cancellables)
    }
}
