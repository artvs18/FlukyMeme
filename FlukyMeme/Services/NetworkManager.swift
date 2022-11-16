//
//  NetworkManager.swift
//  FlukyMeme
//
//  Created by Artemy Volkov on 09.11.2022.
//

import Foundation
import Alamofire

enum Link: String {
    case memeListURL = "https://meme-api.herokuapp.com/gimme/50"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchMemeList(from url: String, completion: @escaping(Result<MemeList, NetworkError>) -> Void) {
        guard let url = URL(string: url) else { completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            do {
                let memeList = try JSONDecoder().decode(MemeList.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(memeList))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
