//
//  DetailPokemonInfoCard.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 9/4/26.
//

import SwiftUI

struct DetailPokemonInfoCard: View {
    let weight: Int
    let height: Int
    
    var body: some View {
        HStack(alignment: .center) {
            
            Spacer()
                
            HStack(spacing: 8) {
                Image("WeightScale")
                    .resizable()
                    .frame(width: 24, height: 24)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(weight.toDecimalString()) kg")
                        .font(.custom("Montserrat-Bold", size: 14))
                        .foregroundColor(.primaryBlue)
                    
                    Text("Peso")
                        .font(.custom("Montserrat-Regular", size: 10))
                        .foregroundColor(.secondaryBlue)
                }
            }
            .padding(.leading, 32)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Divider()
                
            HStack(spacing: 8) {
                Image("Ruler")
                    .resizable()
                    .frame(width: 24, height: 24)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(height.toDecimalString()) m")
                        .font(.custom("Montserrat-Bold", size: 14))
                        .foregroundColor(.primaryBlue)
                    
                    Text("Altura")
                        .font(.custom("Montserrat-Regular", size: 10))
                        .foregroundColor(.secondaryBlue)
                }
            }
            .padding(.leading, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .frame(height: 58)
        .background(Color.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
