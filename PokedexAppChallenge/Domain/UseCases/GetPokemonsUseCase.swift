//
//  GetPokemonsUseCase.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import Foundation

class GetPokemonsUseCase {

    /// Use case responsible for fetching Pokemons list data from the repository
    
    private let repository: PokemonRepository

    init(repository: PokemonRepository = PokemonRepositoryImpl()) {
        self.repository = repository
    }

    func execute(offset: Int, limit: Int, completion: @escaping (Result<[PokemonDTO], NetworkError>) -> Void) {
        repository.getPokemons(offset: offset, limit: limit, completion: completion)
    }
}
