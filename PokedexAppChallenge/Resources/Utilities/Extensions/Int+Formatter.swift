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
}
