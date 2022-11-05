//
//  Meme.swift
//  FlukyMeme
//
//  Created by Artemy Volkov on 04.11.2022.
//

struct Meme: Decodable {
    let postLink: String
    let subreddit: String
    let title: String
    let url: String
    let nsfw: Bool
    let spoiler: Bool
    let author: String
    let ups: Int
    let preview: [String]
}
