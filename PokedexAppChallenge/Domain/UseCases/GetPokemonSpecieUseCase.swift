//
//  GetPokemonSpecieUseCase.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 9/4/26.
//

import Foundation

class GetPokemonSpecieUseCase {
    
    /// Use case responsible for fetching specie Pokemon data from the repository

    private let repository: PokemonRepository

    init(repository: PokemonRepository = PokemonRepositoryImpl()) {
        self.repository = repository
    }

    func execute(url: String, completion: @escaping (Result<PokemonSpecieDTO, NetworkError>) -> Void) {
        repository.getPokemonSpecie(url: url, completion: completion)
    }
}
