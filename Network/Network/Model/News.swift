//
//  News.swift
//  Network
//
//  Created by Nikolai Sokol on 01.06.2021.
//

import Foundation

struct News: Decodable {
    var title: String
    var description: String?
    var urlToSource: String
    var urlToImage: String?
    var content: String?
    
   private enum CodingKeys: String, CodingKey {
        case title
        case description
        case urlToSource = "url"
        case urlToImage
        case content
    }
}

struct Response: Decodable {
    var articles: [News]
}
