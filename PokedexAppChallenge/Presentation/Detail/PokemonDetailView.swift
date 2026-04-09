//
//  PokemonDetailView.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 8/4/26.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject var viewModel: PokemonDetailViewModel
    
    var url: String
    
    var body: some View {
        VStack {
            Text("\(url)")
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
        .onAppear {
            viewModel.getDetail(url: url)
        }
    }
}

#Preview {
    let viewModel = Injector.shared.container.resolve(PokemonDetailViewModel.self)!
    PokemonDetailView(viewModel: viewModel, url: "/")
}
