//
//  CustomPill.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 9/4/26.
//

import SwiftUI

struct CustomPill: View {
    let text: String
    var body: some View {
        VStack {
            Text("\(text)")
                .font(.system(size: 14, weight: .medium))
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
                .background(Color.white)
                .foregroundColor(.red)
                .clipShape(Capsule())
                .overlay(
                    Capsule().stroke(Color.red, lineWidth: 1)
                )
                .padding(.bottom, 12)
        }
    }
}
