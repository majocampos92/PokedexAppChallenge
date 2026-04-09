//
//  Int+Formatter.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 9/4/26.
//

import Foundation

extension Int {
    func toDecimalString() -> String {
        return String(format: "%d,0", self)
    }
    
    func toKilogramsString() -> String {
        let kg = Double(self) / 10.0
        return String(format: "%.1f", kg).replacingOccurrences(of: ".", with: ",")
    }
    
    func toMetersString() -> String {
        let meters = Double(self) / 10.0
        return String(format: "%.1f", meters).replacingOccurrences(of: ".", with: ",")
    }
}
