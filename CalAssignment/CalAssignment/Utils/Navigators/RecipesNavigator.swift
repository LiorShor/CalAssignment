//
//  RecipesNavigator.swift
//  CalAssignment
//
//  Created by Lior Shor on 23/11/2024.
//

import Foundation
import SwiftUI

enum Destination: Hashable {
    case recipe(_ selectedEncryptedRecipe: String)
}

class RecipesNavigator: RecipesRouter, ObservableObject {

    @Published var path: [Destination] = []
    lazy var viewModel = RecipesViewModel(repository: RecipesRepository(recipeService: RecipeClient()), router: self)
    
    func didTapRecipe(_ selectedEncryptedRecipe: String) {
        path.append(.recipe(selectedEncryptedRecipe))
    }
    
    struct ContentView: View {
        @ObservedObject var navigator: RecipesNavigator
        
        var body: some View {
            NavigationStack(path: $navigator.path) {
                RecipesView(viewModel: navigator.viewModel)
                    .navigationDestination(for: Destination.self) { destination in
                        switch destination {
                        case let .recipe(selectedEncryptedRecipe):
                            RecipeDetails(viewModel: RecipeDetailsViewModel(encryptedRecipe: selectedEncryptedRecipe))
                        }
                    }
            }
        }
    }
}
