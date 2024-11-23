//
//  RecipesViewModel.swift
//  CalAssignment
//
//  Created by Lior Shor on 22/11/2024.
//

import Foundation
import Combine

class RecipesViewModel: ObservableObject {
    enum ViewState: Equatable {
        case loading
        case loaded([Recipe])
        case error
    }
    
    @Published var selectedEncryptedRecipe: String = .empty
    @Published var isRecipeDetailsPresented: Bool = false
    @Published var viewState: ViewState = .loading
    
    private let repository: RecipesRepository
    private var cancellables: Set<AnyCancellable> = []
    
    init(repository: RecipesRepository) {
        self.repository = repository
        fetchRecipes()
    }
    
    private func fetchRecipes() {
        repository.fetchRecipes()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    self.viewState = .error
                }
            } receiveValue: { recipes in
                self.viewState = .loaded(recipes)
            }.store(in: &cancellables)
    }
    func didTapRecipe(with recipe: Recipe) {
        selectedEncryptedRecipe = CryptoHelper.encrypt(recipe: recipe) ?? .empty
        isRecipeDetailsPresented = true
    }
}
