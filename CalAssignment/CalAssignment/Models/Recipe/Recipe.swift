//
//  Recipe.swift
//  CalAssignment
//
//  Created by Lior Shor on 22/11/2024.
//

import Foundation

struct Recipe: Codable, Equatable, Identifiable {
    let id: String?
    let name: String?
    let calories: String?
    let carbos: String?
    let description: String?
    let headline: String?
    let proteins: String?
    let time: String?
    let fats: String?
    let difficulty: Int?
    let imageURL: URL?
    let thumbURL: URL?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image"
        case thumbURL = "thumb"
        case id
        case name
        case calories
        case carbos
        case description
        case headline
        case proteins
        case time
        case fats
        case difficulty
    }
}
