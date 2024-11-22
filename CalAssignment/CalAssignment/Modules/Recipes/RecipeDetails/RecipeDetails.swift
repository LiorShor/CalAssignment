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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    RecipeDetails(name: "Name", fats: "6 grams", calories: "232 calories", carbos: "3 grams", description: "This is a description", imageURL: URL(string: "https://img.hellofresh.com/f_auto,q_auto/hellofresh_s3/image/533143aaff604d567f8b4571.jpg")!)
}
