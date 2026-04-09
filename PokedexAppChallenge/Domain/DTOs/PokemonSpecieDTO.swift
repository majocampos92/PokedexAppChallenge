//
//  PokemonSpecieDTO.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 9/4/26.
//

import Foundation

// MARK: - Species
struct PokemonSpecieDTO: Codable {
    let description: String
    let eggGroups: [String]
}
