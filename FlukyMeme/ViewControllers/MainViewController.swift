//
//  MainViewController.swift
//  FlukyMeme
//
//  Created by Artemy Volkov on 04.11.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var memeImageView: UIImageView!

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var memeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchFlukyMeme()
    }
    
    @IBAction func flukeMemeButtonTapped(_ sender: UIButton) {
        activityIndicator.startAnimating()
        fetchFlukyMeme()
    }
}

extension MainViewController {
    private func fetchFlukyMeme() {
        NetworkManager.shared.fetch(Meme.self, from: Link.url.rawValue) { [weak self] result in
            switch result {
            case .success(let meme):
                self?.memeLabel.text = meme.title
                self?.fetchMemeImage(from: meme.url)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchMemeImage(from url: String) {
        NetworkManager.shared.fetchImage(from: url) { [weak self] result in
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
