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

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchMemeList(from url: String, completion: @escaping(Result<MemeList, AFError>) -> Void) {
        AF.request(url)
            .responseDecodable(of: MemeList.self) { response in
                switch response.result {
                case .success(let memeList):
                    completion(.success(memeList))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchImageData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
