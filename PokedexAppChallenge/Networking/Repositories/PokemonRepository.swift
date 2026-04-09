//
//  PokemonRepository.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import Foundation

protocol PokemonRepository {
    func getPokemons(offset: Int, limit: Int, completion: @escaping (Result<[Pokemon], NetworkError>) -> Void)
    func getPokemonByQuery(query: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void)
    func getPokemonDetail(url: String, completion: @escaping (Result<PokemonDetailDTO, NetworkError>) -> Void)
}

final class PokemonRepositoryImpl: PokemonRepository {

    private let apiClient: APIClient

    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getPokemonDetail(url: String, completion: @escaping (Result<PokemonDetailDTO, NetworkError>) -> Void) {
        apiClient.request(endpoint: .getPokemonDetail(url: url)) {(result: Result<PokemonDetailResponse, NetworkError>) in

            switch result {
            case .success(let detail):

                let imageUrl =
                detail.sprites?.other?.home?.frontDefault ??
                detail.sprites?.frontDefault ?? ""
                
                let stats: [StatDTO] = detail.stats?.map { stat in
                    StatDTO(
                        name: stat.stat?.name ?? "",
                        value: stat.baseStat ?? 0
                    )
                } ?? []

                let pokemon = PokemonDetailDTO(
                    id: detail.id ?? 0,
                    name: detail.name ?? "",
                    imageUrl: imageUrl,
                    weight: detail.weight ?? 0,
                    height: detail.height ?? 0,
                    stats: stats
                )
                
                completion(.success(pokemon))

            case .failure(let error):
                completion(.failure(error))
                print("Error fetching pokemon detail:", error.localizedDescription)
            }
        }
    }

    func getPokemons(offset: Int, limit: Int, completion: @escaping (Result<[Pokemon], NetworkError>) -> Void) {

        apiClient.request(endpoint: .getPokemons(offset: offset, limit: limit)) {
            (result: Result<PokemonListResponse, NetworkError>) in

            switch result {
            case .success(let response):

                guard let results = response.results else {
                    completion(.success([]))
                    return
                }

                self.fetchDetails(from: results, completion: completion)

            case .failure(let error):
                completion(.failure(error))
                print("Error fetching pokemon:", error.localizedDescription)
            }
        }
    }
    
    func getPokemonByQuery(query: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        apiClient.request(endpoint: .getPokemonByQuery(query: query)) { (result: Result<PokemonDetailResponse, NetworkError>) in
            
            switch result {
            case .success(let response):
                
                let imageUrl =
                response.sprites?.other?.home?.frontDefault ??
                response.sprites?.frontDefault ?? ""

                let pokemon = Pokemon(
                    id: response.id ?? 0,
                    name: response.name ?? "",
                    imageUrl: imageUrl,
                    url: "NaN"
                )
                
                completion(.success(pokemon))
                
            case .failure(let error):
                print("Error searching pokemon:", error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}

private extension PokemonRepositoryImpl {

    private func fetchDetails(from results: [PokemonResult], completion: @escaping (Result<[Pokemon], NetworkError>) -> Void) {

        let urls = results.compactMap { $0.url }

        var pokemons: [Pokemon] = []
        let group = DispatchGroup()

        for url in urls {
            group.enter()

            fetchPokemonDetail(url: url) { result in
                defer { group.leave() }

                switch result {
                case .success(let pokemon):
                    pokemons.append(pokemon)
                    
                case .failure(let error):
                    print("Detail error:", error.localizedDescription)
                }
            }
        }

        group.notify(queue: .main) {
            let sorted = pokemons.sorted { $0.id < $1.id }
            completion(.success(sorted))
        }
    }

    private func fetchPokemonDetail(url: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {

        apiClient.request(endpoint: .getPokemonDetail(url: url)) {(result: Result<PokemonDetailResponse, NetworkError>) in

            switch result {
            case .success(let detail):

                let imageUrl =
                detail.sprites?.other?.home?.frontDefault ??
                detail.sprites?.frontDefault ?? ""

                let pokemon = Pokemon(
                    id: detail.id ?? 0,
                    name: detail.name ?? "",
                    imageUrl: imageUrl,
                    url: url
                )

                completion(.success(pokemon))

            case .failure(let error):
                completion(.failure(error))
                print("Error fetching pokemon detail:", error.localizedDescription)
            }
        }
    }
}
