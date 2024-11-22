//
//  RecipeDetails.swift
//  CalAssignment
//
//  Created by Lior Shor on 22/11/2024.
//

import SwiftUI

struct RecipeDetails: View {
    var recipe: Recipe?
    
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
                .clipped() // Make sure the image doesn't overflow
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white.opacity(0.6), Color.clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(height: geometry.size.height * 0.333)
                )
                VStack(alignment: .leading) {
                    Text(recipe?.name)
                        .font(.title)
                    Text("Fats: \(recipe?.fats) | Calories: \(recipe?.calories) | Carbos: \(recipe?.carbos)")
                        .font(.footnote)
                    Text(recipe?.description)
                        .font(.body)
                }.padding(.horizontal)
            }.ignoresSafeArea()
        }
    }
}

#Preview {
    RecipeDetails(recipe: Recipe(id: "1", name: "Name", calories: "2 grams", carbos: "3 grams", description: "This is a description", headline: "headline", proteins: "4 grams", time: "PT35M", fats: "6 grams", difficulty: 2, imageURL: URL(string: "https://img.hellofresh.com/f_auto,q_auto/hellofresh_s3/image/533143aaff604d567f8b4571.jpg")!, thumbURL: URL(string: "https://img.hellofresh.com/f_auto,q_auto,w_300/hellofresh_s3/image/533143aaff604d567f8b4571.jpg")!))
}

//Use recipes.json to build a single-page application that shows a list of recipes via HTTP request  list show only "name", "thumb", "fats", "calories" and "carbos" when clicking on item in list it should open in a different screen all of this data "name", "image", "fats", "calories", "carbos" and "description".  make sure item click with encrypt with biometric and show it in the new screen with decrypt with biometric   https://hf-android-app.s3-eu-west-1.amazonaws.com/android-test/recipes.json  Requirements Implement data loading, basic UI, error handling. Keep in mind code readability, scalability, and maintainability when making implementation decisions.  
