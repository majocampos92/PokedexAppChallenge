//
//  PokemonDetailView.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 8/4/26.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject var viewModel: PokemonDetailViewModel = .make()
    
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
    PokemonDetailView(url: "/")
}
