//
//  RecipesViewModel.swift
//  CalAssignment
//
//  Created by Lior Shor on 22/11/2024.
//

import Foundation
import Combine

protocol RecipesRouter: AnyObject {
    func didTapRecipe(_ selectedEncryptedRecipe: String)
}

class RecipesViewModel: ObservableObject {
    enum ViewState: Equatable {
        case loading
        case loaded([Recipe])
        case error
    }
    
    @Published var selectedEncryptedRecipe: String = .empty
    @Published var viewState: ViewState = .loading
    private weak var router: RecipesRouter?
    private weak var repository: RecipesRepositoriable?
    private var cancellables: Set<AnyCancellable> = []
    
    init(repository: RecipesRepositoriable, router: RecipesRouter) {
        self.repository = repository
        self.router = router
        fetchRecipes()
    }
    
    private func fetchRecipes() {
        repository?.fetchRecipes()
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
        BiometricHelper.authenticate(reason: "Authenticate to view the recipe details") { success in
            if success  {
                self.selectedEncryptedRecipe = CryptoHelper.encrypt(recipe: recipe) ?? .empty
                self.router?.didTapRecipe(self.selectedEncryptedRecipe)
            }
        }
    }
}
