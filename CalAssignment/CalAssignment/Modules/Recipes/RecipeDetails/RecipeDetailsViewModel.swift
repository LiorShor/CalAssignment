//
//  RecipeDetailsViewModel.swift
//  CalAssignment
//
//  Created by Lior Shor on 22/11/2024.
//

import Foundation
import LocalAuthentication

enum AuthenticationStatus {
    case authenticating
    case authenticated
    case failure
}

class RecipeDetailsViewModel: ObservableObject {
    
    var encryptedRecipe: String
    @Published var authenticationStatus: AuthenticationStatus = .authenticating
    @Published var recipe: Recipe?
    
    init(encryptedRecipe: String) {
        self.encryptedRecipe = encryptedRecipe
        authenticateAndDecrypt()
    }
    
    func authenticateAndDecrypt() {
        BiometricHelper.authenticate(reason: "Authenticate to view the recipe details") { success in
            if success {
                // Decrypt the entire recipe after successful authentication
                if let encryptedRecipe = CryptoHelper.decrypt(encryptedRecipe: self.encryptedRecipe) {
                    self.recipe = encryptedRecipe
                    self.authenticationStatus = .authenticated
                }
            } else {
                self.authenticationStatus = .failure
            }
        }
    }
}
