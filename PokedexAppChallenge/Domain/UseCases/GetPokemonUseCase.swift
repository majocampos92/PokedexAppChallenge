//
//  GetPokemonUseCase.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 8/4/26.
//

import Foundation

class GetPokemonUseCase {

    private let repository: PokemonRepository

    init(repository: PokemonRepository = PokemonRepositoryImpl()) {
        self.repository = repository
    }

    func execute(query: String, completion: @escaping (Result<PokemonDTO, NetworkError>) -> Void) {
        repository.getPokemonByQuery(query: query, completion: completion)
    }
}
