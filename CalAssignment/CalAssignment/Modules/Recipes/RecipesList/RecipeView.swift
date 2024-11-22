//
//  RecipeView.swift
//  CalAssignment
//
//  Created by Lior Shor on 22/11/2024.
//

import SwiftUI

struct RecipeView: View {
    var recipe: Recipe
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: recipe.thumbURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
                    .controlSize(.large)
            }
            .frame(height: 100)
            .clipShape(
                .rect(
                    topLeadingRadius: 10,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 10
                )
            )
            VStack {
                Text(recipe.name ?? .empty)
                    .font(.title3)
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                Spacer()
                VStack(spacing: 0) {
                    Text("Calories: \(recipe.calories ?? .empty)")
                    Text("Fats: \(recipe.fats ?? .empty)")
                    Text("Carbos: \(recipe.carbos ?? .empty)")
                }
                .font(.footnote)
                .multilineTextAlignment(.leading)
            }
        }
        .frame(width: 150, height: 250)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.primary, lineWidth: 1)
        )
        
    }
}

#Preview {
    RecipeView(recipe: Recipe(id: "1", name: "Name", calories: "2 grams", carbos: "3 grams", description: "This is a description", headline: "headline", proteins: "4 grams", time: "PT35M", fats: "6 grams", difficulty: 2, imageURL: URL(string: "https://img.hellofresh.com/f_auto,q_auto/hellofresh_s3/image/533143aaff604d567f8b4571.jpg")!, thumbURL: URL(string: "https://img.hellofresh.com/f_auto,q_auto,w_300/hellofresh_s3/image/533143aaff604d567f8b4571.jpg")!))
}
