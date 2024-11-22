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
            VStack(alignment: .leading) {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.recipes) { recipe in
                            RecipeView(recipe: recipe)
                                .onTapGesture {
                                    viewModel.didTapRecipe(with: recipe)
                                }
                        }
                    }
                    .padding()
                }
            }
        }.fullScreenCover(isPresented: $viewModel.isRecipeDetailsPresented) {
            NavigationView{
                RecipeDetails(viewModel: RecipeDetailsViewModel(encryptedRecipe: viewModel.selectedEncryptedRecipe))
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
    RecipesView(viewModel: RecipesViewModel(repository: RecipesRepository()))
}
