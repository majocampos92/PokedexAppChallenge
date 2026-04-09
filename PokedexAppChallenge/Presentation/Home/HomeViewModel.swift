//
//  HomeViewModel.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import Foundation

final class HomeViewModel {

    // MARK: - Dependencies
    private let getAllPokemons: GetPokemonsUseCase
    private let searchPokemon: GetPokemonUseCase

    // MARK: - Data
    private(set) var pokemons: [PokemonDTO] = []

    // MARK: - Binding
    var onReloadData: (() -> Void)?
    var onDataUpdated: (([IndexPath]) -> Void)?
    var onError: ((String) -> Void)?

    // MARK: - Pagination
    private var offset = 0
    private let limit = 10
    private var isLoading = false
    private var hasMoreData = true
    
    // MARK: - Search
    var isSearching = false

    // MARK: - Init
    init(
        getAllPokemons: GetPokemonsUseCase,
        searchPokemon: GetPokemonUseCase
    ) {
        self.getAllPokemons = getAllPokemons
        self.searchPokemon = searchPokemon
    }

    // MARK: - Fetch pokemons with pagination
    func fetchPokemons() {
        guard !isLoading, hasMoreData, !isSearching else { return }
        isLoading = true

        getAllPokemons.execute(offset: offset, limit: limit) { [weak self] result in
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
    
    func searchPokemon(query: String) {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuery.isEmpty else {
            resetSearch()
            return
        }
        
        guard !isLoading else { return }
        isLoading = true

        searchPokemon.execute(query: trimmedQuery.lowercased()) { [weak self] result in
            guard let self = self else { return }

            self.isLoading = false

            switch result {
            case .success(let pokemon):
                
                self.isSearching = true
                self.pokemons = [pokemon]
                self.onReloadData?()

            case .failure(let error):
                self.onError?(error.userMessage)
            }
        }
    }
    
    func resetSearch() {
        guard isSearching else { return }
        
        isSearching = false
        pokemons.removeAll()
        offset = 0
        hasMoreData = true
        onReloadData?()
        fetchPokemons()
    }
}
