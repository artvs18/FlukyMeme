//
//  MemeCell.swift
//  FlukyMeme
//
//  Created by Artemy Volkov on 10.11.2022.
//

import UIKit

class MemeCell: UITableViewCell {
    @IBOutlet var memeLabel: UILabel!
    @IBOutlet var memeImageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    func configure(with meme: Meme) {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        memeLabel.text = meme.title
        
        NetworkManager.shared.fetchImageData(from: meme.url) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.memeImageView.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}
