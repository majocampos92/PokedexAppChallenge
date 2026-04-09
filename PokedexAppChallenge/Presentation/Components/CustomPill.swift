//
//  CustomPill.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 9/4/26.
//

import SwiftUI

struct CustomPill: View {
    let text: String
    let color: Color =  Color.random()
    
    var body: some View {
        VStack {
            Text("\(text)")
                .font(.custom("Montserrat-Medium", size: 10))
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
                .background(Color("BackgroundPrimary").opacity(0.8))
                .foregroundColor(color)
                .clipShape(Capsule())
                .overlay(
                    Capsule().stroke(color, lineWidth: 1)
                )
                .padding(.bottom, 12)
        }
    }
}
