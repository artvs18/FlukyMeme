//
//  MemeCell.swift
//  FlukyMeme
//
//  Created by Artemy Volkov on 10.11.2022.
//

import UIKit
import Kingfisher

class MemeCell: UITableViewCell {
    @IBOutlet var memeLabel: UILabel!
    @IBOutlet var memeImageView: AnimatedImageView!
    
    func configure(with meme: Meme) {
        memeLabel.text = meme.title
        guard let imageURL = URL(string: meme.url) else { return }
        let processor = DownsamplingImageProcessor(size: memeImageView.bounds.size)
        memeImageView.kf.indicatorType = .activity
        memeImageView.kf.setImage(
            with: imageURL,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
    }
}

