//
//  PokemonListResponse.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import Foundation

// MARK: - PokemonListResponse
struct PokemonListResponse: Decodable {
    let results: [PokemonResult]?
}

// MARK: - PokemonResult
struct PokemonResult: Decodable {
    let name: String?
    let url: String?
}
