//
//  PokemonSpecieResponse.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 9/4/26.
//

import Foundation

// MARK: - PokemonSpecieResponse
struct PokemonSpecieResponse: Codable {
    let baseHappiness, captureRate: Int?
    let color: Info?
    let eggGroups: [Info]?
    let flavorTextEntries: [FlavorTextEntry]?

    enum CodingKeys: String, CodingKey {
        case baseHappiness = "base_happiness"
        case captureRate = "capture_rate"
        case color
        case eggGroups = "egg_groups"
        case flavorTextEntries = "flavor_text_entries"
    }
}

// MARK: - Info
struct Info: Codable {
    let name: String?
    let url: String?
}

// MARK: - EvolutionChain
struct EvolutionChain: Codable {
    let url: String?
}

// MARK: - FlavorTextEntry
struct FlavorTextEntry: Codable {
    let flavorText: String?
    let language, version: Info?

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language, version
    }
}
