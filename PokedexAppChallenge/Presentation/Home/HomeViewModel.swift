//
//  HomeViewModel.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import Foundation

final class HomeViewModel {

    private let useCase: GetPokemonsUseCase

    private(set) var pokemons: [Pokemon] = []

    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?

    private var offset = 0
    private let limit = 10
    private var isLoading = false

    init(useCase: GetPokemonsUseCase) {
        self.useCase = useCase
    }

    // MARK: - Fetch
    func fetchPokemons() {
        guard !isLoading else { return }
        isLoading = true

        useCase.execute(offset: offset, limit: limit) { [weak self] result in
            guard let self = self else { return }

            self.isLoading = false

            switch result {
            case .success(let newPokemons):
                self.offset += self.limit
                self.pokemons.append(contentsOf: newPokemons)
                self.onDataUpdated?()

            case .failure(let error):
                self.onError?(error.userMessage)
            }
        }
    }
}
