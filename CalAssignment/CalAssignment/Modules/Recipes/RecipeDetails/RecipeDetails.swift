//
//  RecipeDetails.swift
//  CalAssignment
//
//  Created by Lior Shor on 22/11/2024.
//

import SwiftUI

struct RecipeDetails: View {
    var name: String
    var fats: String
    var calories: String
    var carbos: String
    var description: String
    var imageURL: URL
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                AsyncImage(url: imageURL) { image in
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
                    Text(name)
                        .font(.title)
                    Text("Fats: \(fats) | Calories: \(calories) | Carbos: \(carbos)")
                        .font(.footnote)
                    Text(description)
                        .font(.body)
                }.padding(.horizontal)
            }.ignoresSafeArea()
        }
    }
}

#Preview {
    RecipeDetails(name: "Name", fats: "6 grams", calories: "232 calories", carbos: "3 grams", description: "This is a description", imageURL: URL(string: "https://img.hellofresh.com/f_auto,q_auto/hellofresh_s3/image/533143aaff604d567f8b4571.jpg")!)
}
