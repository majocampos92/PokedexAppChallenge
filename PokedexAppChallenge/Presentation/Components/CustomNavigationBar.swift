//
//  CustomNavigationBar.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 9/4/26.
//

import SwiftUI

struct CustomNavigationBar: View {
    let title: String
    let id: String
    let onBack: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                onBack()
            }) {
                HStack(spacing: 8.0) {
                    Image("Arrow")
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                    Text(title.capitalizeFirstLetter())
                        .font(.custom("Montserrat-Bold", size: 16))
                        .foregroundColor(Color("PrimaryBlue"))
                }
            }
            .contentShape(Rectangle())
            
            Spacer()
            
            Text(id)
                .font(.custom("Montserrat-SemiBold", size: 16))
                .foregroundColor(Color("LightGrey"))
        }
        .frame(height: 44)
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .background(Color("backgroundPrimary"))
    }
}
