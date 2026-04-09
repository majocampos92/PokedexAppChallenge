//
//  GetPokemonDetailUseCase.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 8/4/26.
//

import Foundation

class GetPokemonDetailUseCase {
    
    /// Use case responsible for fetching detail Pokemon data from the repository

    private let repository: PokemonRepository

    init(repository: PokemonRepository = PokemonRepositoryImpl()) {
        self.repository = repository
    }

    func execute(url: String, completion: @escaping (Result<PokemonDetailDTO, NetworkError>) -> Void) {
        repository.getPokemonDetail(url: url, completion: completion)
    }
}
