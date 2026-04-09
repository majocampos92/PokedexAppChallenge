//
//  PokemonAPI.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import Foundation

/// Defines all available API endpoints related to Pokemon data

enum PokemonAPI {
    case getPokemons(offset: Int, limit: Int)      // Paginated list
    case getPokemonDetail(url: String)             // Detail by full URL
    case getPokemonByQuery(query: String)          // Search by name or ID
    case getPokemonSpeice(url: String)             // Species info by URL
}

extension PokemonAPI {
    
    // Builds the full URL string for each endpoint
    var url: String {
        switch self {
        case .getPokemons(let offset, let limit):
            return "\(Constants.baseUrl)pokemon?offset=\(offset)&limit=\(limit)"
        case .getPokemonDetail(let url):
            return url
        case .getPokemonByQuery(let query):
            return "\(Constants.baseUrl)pokemon/\(query)"
        case .getPokemonSpeice(let url):
            return url
        }
    }
}
