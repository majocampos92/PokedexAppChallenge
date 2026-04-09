//
//  PokemonDetailDTO.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 8/4/26.
//

import Foundation

// MARK: - Pokemon Detail
struct PokemonDetailDTO {
    let id: Int
    let name: String
    let imageUrl: String
    let weight: Int
    let height: Int
    let stats: [StatDTO]
}

// MARK: - Stat
struct StatDTO {
    let name: String
    let value: Int
}
