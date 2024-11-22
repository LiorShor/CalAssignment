//
//  RecipeView.swift
//  CalAssignment
//
//  Created by Lior Shor on 22/11/2024.
//

import SwiftUI

struct RecipeView: View {
    var url: URL
    var name: String
    var fatsAmount: String
    var calories: String
    var carbos: String
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
                    .controlSize(.large)
            }
            .frame(width: 150, height: 100)
            .clipShape(
                .rect(
                    topLeadingRadius: 10,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 10
                )
            )
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title)
                VStack(alignment: .leading) {
                    Text("Calories: \(calories)")
                    Text("Fats: \(fatsAmount)")
                    Text("Carbos: \(carbos)")
                }
                .font(.footnote)
            }
        }.overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}

#Preview {
    RecipeView(url: URL(string: "https://img.hellofresh.com/f_auto,q_auto,w_300/hellofresh_s3/image/533143aaff604d567f8b4571.jpg")!, name: "Title", fatsAmount: "2 grams", calories: "26 grams", carbos: "47 grams")
}
