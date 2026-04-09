//
//  PokemonDetailResponse.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import Foundation

// MARK: - PokemonDetail
struct PokemonDetailResponse: Codable {
    let id: Int?
    let name: String?
    let baseExperience: Int?
    let height: Int?
    let isDefault: Bool?
    let order: Int?
    let weight: Int?
    let sprites: Sprites?
    let stats: [Stats]?
    let species: Species?

    enum CodingKeys: String, CodingKey {
        case id, name, height, order, weight, sprites
        case baseExperience = "base_experience"
        case isDefault = "is_default"
        case stats, species
    }
}

// MARK: - Sprites
struct Sprites: Codable {
    let frontDefault: String?
    let frontShiny: String?
    let backDefault: String?
    let backShiny: String?
    let frontFemale: String?
    let backFemale: String?
    let frontShinyFemale: String?
    let backShinyFemale: String?
    
    let other: Other?
    let versions: Versions?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontFemale = "front_female"
        case backFemale = "back_female"
        case frontShinyFemale = "front_shiny_female"
        case backShinyFemale = "back_shiny_female"
        case other, versions
    }
}

// MARK: - Other
struct Other: Codable {
    let home: Home?
    let officialArtwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case home
        case officialArtwork = "official-artwork"
    }
}

// MARK: - Home
struct Home: Codable {
    let frontDefault: String?
    let frontShiny: String?
    let frontFemale: String?
    let frontShinyFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontFemale = "front_female"
        case frontShinyFemale = "front_shiny_female"
    }
}

// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    let frontDefault: String?
    let frontShiny: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

// MARK: - Versions (opcional, pero seguro)
struct Versions: Codable {
    let generationViii: GenerationViii?

    enum CodingKeys: String, CodingKey {
        case generationViii = "generation-viii"
    }
}

// MARK: - GenerationViii
struct GenerationViii: Codable {
    let icons: Icons?
}

// MARK: - Icons
struct Icons: Codable {
    let frontDefault: String?
    let frontFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
    }
}

// MARK: - Stats
struct Stats: Codable {
    let baseStat, effort: Int?
    let stat: Stat?

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - Stat
struct Stat:  Codable {
    let name: String?
    let url: String?
}

// MARK: - Species
struct Species: Codable {
    let name: String?
    let url: String?
}
