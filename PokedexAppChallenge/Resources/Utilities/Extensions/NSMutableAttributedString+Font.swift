//
//  NSMutableAttributedString+Font.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 8/4/26.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    func setFont(_ font: UIFont, for text: String, in fullText: String) {
        guard let range = fullText.range(of: text) else { return }
        let nsRange = NSRange(range, in: fullText)
        addAttribute(.font, value: font, range: nsRange)
    }
}
