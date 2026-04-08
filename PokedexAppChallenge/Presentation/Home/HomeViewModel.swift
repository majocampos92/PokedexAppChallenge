//
//  HomeViewModel.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import Foundation

final class HomeViewModel {

    // MARK: - Dependencies
    private let useCase: GetPokemonsUseCase

    // MARK: - Data
    private(set) var pokemons: [Pokemon] = []

    // MARK: - Binding
    var onDataUpdated: (([IndexPath]) -> Void)?
    var onError: ((String) -> Void)?

    // MARK: - Pagination
    private var offset = 0
    private let limit = 10
    private var isLoading = false
    private var hasMoreData = true

    // MARK: - Init
    init(useCase: GetPokemonsUseCase) {
        self.useCase = useCase
    }

    // MARK: - Fetch pokemons with pagination
    func fetchPokemons() {
        guard !isLoading, hasMoreData else { return }
        isLoading = true

        useCase.execute(offset: offset, limit: limit) { [weak self] result in
            guard let self = self else { return }

            self.isLoading = false

            switch result {
            case .success(let newPokemons):
                if newPokemons.isEmpty {
                    self.hasMoreData = false
                    return
                }

                let startIndex = self.pokemons.count
                let endIndex = startIndex + newPokemons.count

                self.pokemons.append(contentsOf: newPokemons)

                let indexPaths = (startIndex..<endIndex).map {
                    IndexPath(item: $0, section: 0)
                }

                self.offset += self.limit

                self.onDataUpdated?(indexPaths)

            case .failure(let error):
                self.onError?(error.userMessage)
            }
        }
    }
}
