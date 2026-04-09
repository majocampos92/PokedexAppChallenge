//
//  Color+Random.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 9/4/26.
//

import SwiftUI

extension Color {
    static func random() -> Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}
