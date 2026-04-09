//
//  String+Formatter.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 9/4/26.
//

import Foundation

extension String {
    func formattedText() -> String {
        return self
            .replacingOccurrences(of: "-", with: " ")
            .capitalized
    }
    
    func capitalizeFirstLetter() -> String {
        guard let first = self.first else { return self }
        return first.uppercased() + self.dropFirst()
    }
    
    func cleanedText() -> String {
        return self
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\u{000C}", with: " ")
    }
}
