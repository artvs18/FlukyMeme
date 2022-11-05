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
        guard let url = URL(string: "https://meme-api.herokuapp.com/gimme") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }

            let decoder = JSONDecoder()
            do {
                let meme = try decoder.decode(Meme.self, from: data)
                print(meme)
                self?.fetchMemeImage(url: meme.url)
                
                DispatchQueue.main.async {
                    self?.memeLabel.text = meme.title
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
            
           
        }.resume()
    }
    
    private func fetchMemeImage(url: String) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.memeImageView.image = image
                self?.activityIndicator.stopAnimating()
            }
        }.resume()
    }
}
