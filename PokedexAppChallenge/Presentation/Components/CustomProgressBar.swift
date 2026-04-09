//
//  CustomProgressBar.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 9/4/26.
//

import SwiftUI

struct CustomProgressBar: View {
    let value: Int
    let maxValue: Int = 100
    let color: Color
    
    var progress: CGFloat {
        min(CGFloat(value) / CGFloat(maxValue), 1.0)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 26)
                    .fill(color.opacity(0.2))
                    .frame(height: 14)
                
                RoundedRectangle(cornerRadius: 26)
                    .fill(color)
                    .frame(width: geometry.size.width * progress, height: 14)
                    .animation(.easeInOut(duration: 0.6), value: progress)
            }
        }
        .frame(height: 14)
    }
}


struct ProgressBarRow: View {
    let name: String
    let value: Int
    let color: Color
    
    var body: some View {
        HStack {
            Text(name.formattedText())
                .frame(width: 120, alignment: .leading)
                .font(.custom("Montserrat-Medium", size: 14))
                .foregroundColor(.darkGrey)
            
            CustomProgressBar(value: value, color: color)
                .frame(height: 10)
            
            Text("\(value)")
                .frame(width: 40)
                .font(.custom("Montserrat-Bold", size: 14))
                .foregroundColor(.darkGrey)
        }
    }
}
