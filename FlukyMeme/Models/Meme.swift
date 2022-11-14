//
//  Meme.swift
//  FlukyMeme
//
//  Created by Artemy Volkov on 04.11.2022.
//

struct MemeList {
    let count: Int
    let memes: [Meme]
    
    init(memeListData: [String: Any]) {
        let memesData = memeListData["memes"] as? [[String: Any]]
        count = memeListData["count"] as? Int ?? 0
        memes = memesData?.map { Meme(memeData: $0) } ?? []
    }
    
    static func getMemeListData(from value: Any) -> MemeList {
        guard let memeListData = value as? [String: Any] else { return MemeList(memeListData: [:]) }
        return MemeList(memeListData: memeListData)
    }
}

struct Meme {
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
    
    init(memeData: [String: Any]) {
        postLink = memeData["postLink"] as? String ?? ""
        subreddit = memeData["subreddit"] as? String ?? ""
        title = memeData["title"] as? String ?? ""
        url = memeData["url"] as? String ?? ""
        author = memeData["author"] as? String ?? ""
        ups = memeData["ups"] as? Int ?? 0
    }
}
