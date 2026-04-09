//
//  PokemonDetailViewModel.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 8/4/26.
//

import Foundation
import SwiftUI

final class PokemonDetailViewModel: ObservableObject {
    
    // MARK: - State
    @Published var detail: PokemonDetailDTO? = nil
    @Published var specie: PokemonSpecieDTO? = nil
    @Published var isLoading: Bool = false
    
    // MARK: - Dependencies
    private let getPokemonDetail: GetPokemonDetailUseCase
    private let getPokemonSpecie: GetPokemonSpecieUseCase
    
    // MARK: - Binding
    var onError: ((String) -> Void)?
    
    // MARK: - Variables
    var color: Color = Color.random()
    
    // MARK: - Init
    init(
        getPokemonDetail: GetPokemonDetailUseCase,
        getPokemonSpecie: GetPokemonSpecieUseCase
    ) {
        self.getPokemonDetail = getPokemonDetail
        self.getPokemonSpecie = getPokemonSpecie
    }
    
    func getDetail(url: String?) {
        guard let url = url, !url.isEmpty else {
            onError?("URL inválida")
            return
        }
        
        isLoading = true
        
        getPokemonDetail.execute(url: url) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let detail):
                    self.detail = detail
                    
                case .failure(let error):
                    self.onError?(error.userMessage)
                }
            }
        }
    }
    
    func getSpecie(url: String?) {
        guard let url = url, !url.isEmpty else {
            onError?("URL inválida")
            return
        }
        
        getPokemonSpecie.execute(url: url) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let specie):
                    self.specie = specie
                    
                case .failure(let error):
                    self.onError?(error.userMessage)
                }
            }
        }
    }
}
