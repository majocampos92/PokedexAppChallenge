//
//  PokemonResponse.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 8/4/26.
//

import Foundation

struct PokemonResponse: Codable {
    let id: Int?
    let name: String?
    let baseExperience: Int?
    let height: Int?
    let isDefault: Bool?
    let order: Int?
    let weight: Int?
    let sprites: Sprites?

    enum CodingKeys: String, CodingKey {
        case id, name, height, order, weight, sprites
        case baseExperience = "base_experience"
        case isDefault = "is_default"
    }
}
