//
//  PokemonDetailView.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 8/4/26.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    @StateObject var viewModel: PokemonDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    var url: String
    
    var body: some View {
        VStack(spacing: 16.0) {
            
                CustomNavigationBar(title: viewModel.detail?.name ?? "", id: "#\(viewModel.detail?.id ?? 0)") { dismiss() }
            
                GeometryReader { reader in

                ScrollView(showsIndicators: false) {
                    //MARK: - IMAGE
                    VStack (alignment: .center) {
                        
                        ZStack(alignment: .top) {
                            // MARK: - CARD
                            RoundedRectangle(cornerRadius: 20)
                                .fill(viewModel.color)
                                .frame(height: 175)
                                .padding(.top, 60)
                            
                            // MARK: - IMAGE
                            if let imageUrl = viewModel.detail?.imageUrl,
                               let url = URL(string: imageUrl) {
                                
                                KFImage(url)
                                    .placeholder {
                                        ProgressView()
                                            .progressViewStyle(.circular)
                                    }
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 225, height: 225)
                                    .offset(y: -25)
                            }
                            
                            // MARK: - TYPE BADGE
//                            HStack(alignment: .center) {
//                                Pill(text: "🔥 Fuego")
//                            }
                        }
                    }
                    .frame(height: 255)
                    
                    //MARK: - Info
                    DetailPokemonInfoCard(
                        weight: viewModel.detail?.weight ?? 0,
                        height: viewModel.detail?.height ?? 0
                    )
                    
                    //MARK: - Description
                    Text("")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(4)
                    
                    //MARK: - Stats
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Estadísticas")
                            .font(.custom("Montserrat-Bold", size: 20))
                            .foregroundColor(.primaryBlue)
                        
                        ForEach(viewModel.detail?.stats ?? [], id: \.name) { stat in
                            ProgressBarRow(name: stat.name, value: stat.value, color: viewModel.color)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .background(.backgroundPrimary)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .onAppear {
            viewModel.getDetail(url: url)
        }
    }
}

#Preview {
    let viewModel = Injector.shared.container.resolve(PokemonDetailViewModel.self)!
    PokemonDetailView(viewModel: viewModel, url: "/")
}
