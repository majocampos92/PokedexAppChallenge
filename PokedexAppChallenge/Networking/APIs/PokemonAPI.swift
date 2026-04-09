//
//  PokemonAPI.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import Foundation

enum PokemonAPI {
    case getPokemons(offset: Int, limit: Int)
    case getPokemonDetail(url: String)
    case getPokemonByQuery(query: String)
}

extension PokemonAPI {

    var url: String {
        switch self {
        case .getPokemons(let offset, let limit):
            return "\(Constants.baseUrl)pokemon?offset=\(offset)&limit=\(limit)"
        case .getPokemonDetail(let url):
            return url
        case .getPokemonByQuery(let query):
            return "\(Constants.baseUrl)pokemon/\(query)"
        }
    }
}
