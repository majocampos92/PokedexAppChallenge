//
//  ImageService.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import UIKit
import Kingfisher

final class ImageService {

    @MainActor func loadImage(from url: String, into imageView: UIImageView) {
        guard let url = URL(string: url) else { return }

        imageView.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ]
        )
    }
}
