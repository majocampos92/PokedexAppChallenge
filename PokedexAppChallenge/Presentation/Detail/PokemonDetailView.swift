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
    var specieUrl: String
    
    var body: some View {
        VStack(spacing: 16.0) {
            
                CustomNavigationBar(title: viewModel.detail?.name ?? "", id: "#\(viewModel.detail?.id ?? 0)") { dismiss() }
            
                GeometryReader { reader in

                ScrollView(showsIndicators: false) {
                    //MARK: - IMAGE
                    VStack (alignment: .center, spacing: 20) {
                        
                        ZStack(alignment: .top) {
                            // MARK: - CARD
                            RoundedRectangle(cornerRadius: 20)
                                .fill(viewModel.color)
                                .frame(height: 165)
                                .padding(.top, 100)
                            
                            VStack(spacing: 0) {
                                // MARK: - IMAGE
                                if let imageUrl = viewModel.detail?.imageUrl,
                                   let url = URL(string: imageUrl) {
                                    
                                    KFImage(url)
                                        .placeholder {
                                            ProgressView()
                                                .progressViewStyle(.circular)
                                        }
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 200, height: 200)
                                        .offset(y: -8)
                                }
                                
                                // MARK: - Groups
                                HStack(alignment: .center) {
                                    ForEach(viewModel.specie?.eggGroups ?? [], id: \.self) { egg in
                                        CustomPill(text: egg.capitalizeFirstLetter())
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    //MARK: - Info
                    DetailPokemonInfoCard(
                        weight: viewModel.detail?.weight ?? 0,
                        height: viewModel.detail?.height ?? 0
                    )
                    
                    //MARK: - Description
                    VStack(alignment: .leading) {
                        Text("\(viewModel.specie?.description ?? "Descripción no disponible")")
                            .font(.custom("Montserrat-Medium", size: 12))
                            .foregroundColor(Color("LightGrey"))
                            .multilineTextAlignment(.leading)
                            .lineSpacing(4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 16)
                    }
                    
                    //MARK: - Stats
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Estadísticas")
                            .font(.custom("Montserrat-Bold", size: 20))
                            .foregroundColor(Color("PrimaryBlue"))
                        
                        ForEach(viewModel.detail?.stats ?? [], id: \.name) { stat in
                            ProgressBarRow(name: stat.name, value: stat.value, color: viewModel.color)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .background(Color("BackgroundPrimary"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .onAppear {
            viewModel.getDetail(url: url)
            viewModel.getSpecie(url: specieUrl)
        }
    }
}

#Preview {
    let viewModel = Injector.shared.container.resolve(PokemonDetailViewModel.self)!
    PokemonDetailView(viewModel: viewModel, url: "/", specieUrl: "/")
}
