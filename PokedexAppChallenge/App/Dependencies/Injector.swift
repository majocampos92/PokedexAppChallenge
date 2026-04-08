//
//  DIContainer.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import Foundation

import Foundation
import Swinject

final class Injector {

    static let shared = Injector()
    let container = Container()

    private init() {
        registerDependencies()
    }

    private func registerDependencies() {

        // MARK: - Network
        container.register(APIClient.self) { _ in
            APIClient()
        }
        
        // MARK: - Services
        container.register(ImageService.self) { _ in
            ImageService()
        }

        // MARK: - Repositories
        container.register(PokemonRepository.self) { resolver in
            let apiClient = resolver.resolve(APIClient.self)!
            return PokemonRepositoryImpl(apiClient: apiClient)
        }

        // MARK: - UseCases
        container.register(GetPokemonsUseCase.self) { resolver in
            let repository = resolver.resolve(PokemonRepository.self)!
            return GetPokemonsUseCase(repository: repository)
        }
        
        container.register(GetPokemonUseCase.self) { resolver in
            let repository = resolver.resolve(PokemonRepository.self)!
            return GetPokemonUseCase(repository: repository)
        }

        // MARK: - ViewModel
        container.register(HomeViewModel.self) { resolver in
            let getAllPokemons = resolver.resolve(GetPokemonsUseCase.self)!
            let searchPokemon = resolver.resolve(GetPokemonUseCase.self)!
            return HomeViewModel(getAllPokemons: getAllPokemons, searchPokemon: searchPokemon)
        }
    }
}
