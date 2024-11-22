//
//  Recipe.swift
//  CalAssignment
//
//  Created by Lior Shor on 22/11/2024.
//

import Foundation

struct Recipe: Codable {
    let id: String
    let name: String
    let calories: String
    let carbs: String
    let description: String
    let headline: String
    let proteins: String
    let time: String
    let fats: String
    let difficulty: Int
    let image: URL
    let thumb: URL
}
