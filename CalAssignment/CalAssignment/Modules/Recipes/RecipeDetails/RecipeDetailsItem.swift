//
//  RecipeDetailsView.swift
//  CalAssignment
//
//  Created by Lior Shor on 23/11/2024.
//

import SwiftUI

struct RecipeDetailsItem: View {
    let recipe: Recipe?
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                AsyncImage(url: recipe?.imageURL) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                        .controlSize(.large)
                }
                .frame(height: geometry.size.height * 0.333)
                .clipped() // Make sure image does not overflow
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.primary.opacity(0.6), Color.clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(height: geometry.size.height * 0.333)
                )
                VStack(alignment: .leading) {
                    Text(recipe?.name ?? .empty)
                        .font(.title)
                    Text("Fats: \(recipe?.fats ?? "Unknown") | Calories: \(recipe?.calories ?? "Unknown") | Carbos: \(recipe?.carbos ?? "Unknown")")
                        .font(.footnote)
                    Text(recipe?.description ?? .empty)
                        .font(.body)
                }.padding(.horizontal)
            }.ignoresSafeArea()
        }
    }
}

#Preview {
    RecipeDetailsItem(recipe: Recipe(id: "1", name: "Name", calories: "2 grams", carbos: "3 grams", description: "This is a description", headline: "headline", proteins: "4 grams", time: "PT35M", fats: "6 grams", difficulty: 2, imageURL: URL(string: "https://img.hellofresh.com/f_auto,q_auto/hellofresh_s3/image/533143aaff604d567f8b4571.jpg")!, thumbURL: URL(string: "https://img.hellofresh.com/f_auto,q_auto,w_300/hellofresh_s3/image/533143aaff604d567f8b4571.jpg")!))
}
