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
    @Published var selectedRecipe: Recipe?
    @Published var isRecipeDetailsPresented: Bool = false
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
    
    func didTapRecipe(with recipe: Recipe) {
        selectedRecipe = recipe
        isRecipeDetailsPresented.toggle()
    }
}
