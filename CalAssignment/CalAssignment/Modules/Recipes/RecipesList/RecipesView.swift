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
        NavigationView {
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
        }
        .animation(.smooth, value: viewModel.viewState)
        .fullScreenCover(isPresented: $viewModel.isRecipeDetailsPresented) {
            NavigationView {
                RecipeDetails(viewModel: RecipeDetailsViewModel(encryptedRecipe: viewModel.selectedEncryptedRecipe), isPresented: $viewModel.isRecipeDetailsPresented)
                    .navigationBarItems(leading: Button(action: {
                        viewModel.isRecipeDetailsPresented.toggle()
                    }, label: {
                        Image(systemName: "arrow.left.circle.fill")
                            .font(.title)
                            .foregroundColor(.secondary)
                    })
                    )
            }
        }
    }
}

#Preview {
    RecipesView(viewModel: RecipesViewModel(repository: RecipesRepository(recipeService: RecipeClient())))
}
