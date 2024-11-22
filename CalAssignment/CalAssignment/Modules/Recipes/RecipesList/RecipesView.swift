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
                            RecipeView(url: recipe.thumbURL, name: recipe.name, fatsAmount: recipe.fats, calories: recipe.calories, carbos: recipe.carbos)
                                 .onTapGesture {
                                     viewModel.didTapRecipe(with: recipe)
                                 }
                        }
                    }
                    .padding()
                }
            }
        }.fullScreenCover(isPresented: $viewModel.isRecipeDetailsPresented, content: {
            NavigationView{
                RecipeDetails(recipe: viewModel.selectedRecipe)
                    .navigationBarItems(leading: Button("Back") {
                        viewModel.isRecipeDetailsPresented.toggle()
                    })
            }
        })
    }
}

#Preview {
    RecipesView(viewModel: RecipesViewModel(repository: RecipesRepository()))
}
