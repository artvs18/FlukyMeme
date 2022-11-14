//
//  Meme.swift
//  FlukyMeme
//
//  Created by Artemy Volkov on 04.11.2022.
//

struct MemeList: Decodable {
    let count: Int
    let memes: [Meme]
}

struct Meme: Decodable {
    let postLink: String
    let subreddit: String
    let title: String
    let url: String
    let author: String
    let ups: Int
    
    var memeDescription: String {
        """
        Origin subreddit: \(subreddit)
        Author: \(author)
        Title: \(title)
        Number of upvotes: \(ups)
        Post Link: \(postLink)
        Meme image URL: \(url)
        """
    }
}
