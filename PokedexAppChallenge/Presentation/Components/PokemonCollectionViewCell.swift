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

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
    }

    func configure(with pokemon: Pokemon) {
        namePokemon.text = pokemon.name
        idPokemon.text = "#\(pokemon.id)"

        imagePokemon.image = nil

        ImageLoader.shared.load(url: pokemon.imageUrl) { [weak self] image in
            self?.imagePokemon.image = image
        }
    }
}

final class ImageLoader {

    static let shared = ImageLoader()

    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    func load(url: String, completion: @escaping (UIImage?) -> Void) {

        if let cachedImage = cache.object(forKey: url as NSString) {
            completion(cachedImage)
            return
        }
        
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in

            var image: UIImage?

            if let data = data {
                image = UIImage(data: data)
            }

            if let image = image {
                self.cache.setObject(image, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.main.async {
                completion(image)
            }

        }.resume()
    }
}
