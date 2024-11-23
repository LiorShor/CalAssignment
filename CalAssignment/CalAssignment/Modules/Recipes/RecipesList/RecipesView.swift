//
//  RecipesView.swift
//  CalAssignment
//
//  Created by Lior Shor on 22/11/2024.
//

import SwiftUI

struct RecipesView: View {
    @ObservedObject var viewModel: RecipesViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
            VStack {
                switch viewModel.viewState {
                case let .loaded(recipes):
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(recipes) { recipe in
                                RecipeView(recipe: recipe)
                                    .onTapGesture {
                                        viewModel.didTapRecipe(with: recipe)
                                    }
                            }
                        }
                        .padding()
                    }
                case .error:
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.secondary)
                    Text("Could not load your recipe 🥺")
                        .font(.body)
                        .padding()
                case .loading:
                    Text("Please hold on while we are getting your recipes")
                    ProgressView()
                        .controlSize(.large)
                }
            }
            .navigationDestination(for: Destination.self, destination: { destination in
                switch destination {
                case let .recipe(selectedEncryptedRecipe):
                    RecipeDetails(viewModel: RecipeDetailsViewModel(encryptedRecipe: selectedEncryptedRecipe))
                }
            })
            .navigationBarTitle("Recipes")
            .animation(.smooth, value: viewModel.viewState)
    }
}

#Preview {
    RecipesView(viewModel: RecipesViewModel(repository: RecipesRepository(recipeService: RecipeClient()), router: RecipesNavigator()))
}
