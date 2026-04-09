//
//  GetPokemonDetailUseCase.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 8/4/26.
//

import Foundation

class GetPokemonDetailUseCase {

    private let repository: PokemonRepository

    init(repository: PokemonRepository = PokemonRepositoryImpl()) {
        self.repository = repository
    }

    func execute(url: String, completion: @escaping (Result<PokemonDetailDTO, NetworkError>) -> Void) {
        repository.getPokemonDetail(url: url, completion: completion)
    }
}
