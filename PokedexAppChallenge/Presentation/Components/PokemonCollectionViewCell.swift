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

        contentView.backgroundColor = UIColor(named: "BackgroundSecondary")
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imagePokemon.kf.cancelDownloadTask()
        
        imagePokemon.image = nil
        namePokemon.text = nil
        idPokemon.text = nil
    }

    func configure(with pokemon: PokemonDTO) {
        namePokemon.text = pokemon.name.capitalizeFirstLetter()
        namePokemon.font = UIFont(name: "Montserrat-SemiBold", size: 18)
        namePokemon.textColor = UIColor(named: "PrimaryBlue")
        
        idPokemon.text = "#\(pokemon.id)"
        idPokemon.font = UIFont(name: "Montserrat-Medium", size: 12)
        idPokemon.textColor = UIColor(named: "NeutralGrey")

        imageService.loadImage(from: pokemon.imageUrl, into: imagePokemon)
    }
}
