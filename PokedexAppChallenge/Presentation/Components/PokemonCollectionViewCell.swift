//
//  PokemonCollectionViewCell.swift
//  PokemonAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PokemonCollectionViewCell"
    
    @IBOutlet weak var idPokemon: UILabel!
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var namePokemon: UILabel!
    
    var imageService: ImageService!

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
    }

    func configure(with pokemon: Pokemon) {
        namePokemon.text = pokemon.name
        idPokemon.text = "#\(pokemon.id)"

        imageService.loadImage(from: pokemon.imageUrl, into: imagePokemon)
    }
}
