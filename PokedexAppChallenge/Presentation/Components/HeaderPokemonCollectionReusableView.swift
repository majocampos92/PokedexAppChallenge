//
//  HeaderPokemonCollectionReusableView.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 8/4/26.
//

import UIKit

class HeaderPokemonCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderPokemonCollectionReusableView"
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(text: String) {
        title.text = text
        title.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        title.textColor = UIColor(named: "NeutralGrey")
    }
}
