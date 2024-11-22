//
//  CryptoHelper.swift
//  CalAssignment
//
//  Created by Lior Shor on 22/11/2024.
//

import Foundation
import CryptoKit

class CryptoHelper {
    
    static let key = SymmetricKey(size: .bits256) // Use a secure symmetric key for encryption
    
    ///
    /// Encrypt recipe by 3 steps:
    /// Step 1: serialize recipe object into date
    /// Step 2: Encrypt the data user helper method
    /// Step 3: Return base64-encoded string of the encrypted data
    ///
    static func encrypt(recipe: Recipe) -> String? {
        let encoder = JSONEncoder()
        guard let recipeData = try? encoder.encode(recipe) else { return nil }
        let encryptedData = encrypt(data: recipeData)
        return encryptedData?.base64EncodedString()
    }
    
    ///
    /// Decrypt string into Recipe by 3 steps:
    /// Step 1: Convert base64 string back to encrypted data
    /// Step 2: Decrypt the data
    /// Step 3: Decode Data back into Recipe object
    ///
    static func decrypt(encryptedRecipe: String) -> Recipe? {
        let decoder = JSONDecoder()
        guard let encryptedData = Data(base64Encoded: encryptedRecipe),
                let decryptedData = decrypt(data: encryptedData) else { return nil }
        return try? decoder.decode(Recipe.self, from: decryptedData)
    }
    
    // Helper methods to encrypt and decrypt raw data using symmetric encryption
    private static func encrypt(data: Data) -> Data? {
        do {
            let sealedBox = try AES.GCM.seal(data, using: key)
            return sealedBox.combined
        } catch {
            print("Encryption failed: \(error)")
            return nil
        }
    }
    
    private static func decrypt(data: Data) -> Data? {
        do {
            let box = try AES.GCM.SealedBox(combined: data)
            let decryptedData = try AES.GCM.open(box, using: key)
            return decryptedData
        } catch {
            print("Decryption failed: \(error)")
            return nil
        }
    }
}
