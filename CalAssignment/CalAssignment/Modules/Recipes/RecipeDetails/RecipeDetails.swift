//
//  RecipeDetails.swift
//  CalAssignment
//
//  Created by Lior Shor on 22/11/2024.
//

import SwiftUI

struct RecipeDetails: View {
    @ObservedObject var viewModel: RecipeDetailsViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        // Request biometric authentication and decrypt
        switch viewModel.authenticationStatus {
        case .locked:
            Text("Recipe is locked")
                .font(.body)
            Button("Unlock") {
                viewModel.authenticateAndDecrypt()
            }
            .buttonStyle(BorderedButtonStyle())
            .foregroundStyle(.secondary)
        case .authenticating:
            Text("Authenticating...")
                .font(.body)
        case .authenticated:
            GeometryReader { geometry in
                VStack {
                    AsyncImage(url: viewModel.recipe?.imageURL) { image in
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
                            gradient: Gradient(colors: [Color.white.opacity(0.6), Color.clear]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        .frame(height: geometry.size.height * 0.333)
                    )
                    VStack(alignment: .leading) {
                        Text(viewModel.recipe?.name ?? .empty)
                            .font(.title)
                        Text("Fats: \(viewModel.recipe?.fats ?? "") | Calories: \(viewModel.recipe?.calories ?? "") | Carbos: \(viewModel.recipe?.carbos ?? "")")
                            .font(.footnote)
                        Text(viewModel.recipe?.description ?? .empty)
                            .font(.body)
                    }.padding(.horizontal)
                }.ignoresSafeArea()
            }
        case .failure:
            Image(systemName: "x.circle.fill")
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundColor(.secondary)
            Text("Could not load your dish 🥺")
                .font(.body)
                .padding()
            Button("Back") {
                dismiss()
            }
            .buttonStyle(BorderedButtonStyle())
            .foregroundColor(.secondary)
        }
    }
}

#Preview {
    RecipeDetails(viewModel: RecipeDetailsViewModel(encryptedRecipe: CryptoHelper.encrypt(recipe: Recipe(id: "1", name: "Name", calories: "2 grams", carbos: "3 grams", description: "This is a description", headline: "headline", proteins: "4 grams", time: "PT35M", fats: "6 grams", difficulty: 2, imageURL: URL(string: "https://img.hellofresh.com/f_auto,q_auto/hellofresh_s3/image/533143aaff604d567f8b4571.jpg")!, thumbURL: URL(string: "https://img.hellofresh.com/f_auto,q_auto,w_300/hellofresh_s3/image/533143aaff604d567f8b4571.jpg")!)) ?? .empty))
}
