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
            LockedView()
        case .authenticating:
            Text("Authenticating...")
                .font(.body)
        case .authenticated:
            RecipeDetailsItem(recipe: viewModel.recipe)
        case .failure:
            ErrorView(message: "Could not load your dish 🥺")
        }
    }

    private func LockedView() -> some View {
        VStack {
            Text("Recipe is locked")
                .font(.body)
            Button("Unlock") {
                viewModel.authenticateAndDecrypt()
            }
            .buttonStyle(BorderedButtonStyle())
            .foregroundStyle(.secondary)
        }
    }
    private func ErrorView(message: String) -> some View {
        VStack {
            Image(systemName: "x.circle.fill")
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundColor(.secondary)
            Text(message)
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
