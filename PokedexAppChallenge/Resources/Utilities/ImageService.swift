//
//  ImageService.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import UIKit
import Kingfisher

final class ImageService {

    /// Loads an image with a loading indicator using Kingfisher

    @MainActor func loadImage(from url: String, into imageView: UIImageView) {
        
        guard let url = URL(string: url) else { return }

        imageView.kf.indicatorType = .activity

        imageView.kf.setImage(
            with: url,
            options: [
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ]
        )
    }
}
