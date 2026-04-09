//
//  PokemonDetailViewModel.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 8/4/26.
//

import Foundation

final class PokemonDetailViewModel: ObservableObject {
    
    @Published var detail: PokemonDetailDTO? = nil
    
    // MARK: - Dependencies
    private let getPokemonDetail: GetPokemonDetailUseCase
    
    init(getPokemonDetail: GetPokemonDetailUseCase) {
        self.getPokemonDetail = getPokemonDetail
    }
    
    func getDetail(url: String?) {
        guard let url = url else { return}
        
        getPokemonDetail.execute(url: url) { [weak self] detail in
            print(detail)
        }
    }
}

// MARK: - Extensions
extension PokemonDetailViewModel {
    static func make() -> PokemonDetailViewModel {
        PokemonDetailViewModel(
            getPokemonDetail: Injector.shared.container.resolve(GetPokemonDetailUseCase.self)!
        )
    }
}
