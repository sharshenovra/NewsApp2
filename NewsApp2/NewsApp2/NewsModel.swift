//
//  NewsModel.swift
//  NewsApp2
//
//  Created by Ruslan Sharshenov on 08.12.2021.
//

import Foundation

class NewsModel: Codable {
   public var list: [Articles] = []
    enum CodingKeys: String, CodingKey {
    case list = "articles"
    }
}

class Articles: Codable {
    var title: String? = nil
    var description: String? = nil
    var urlToImage: String? = nil
    
    enum CodingKeys: String, CodingKey {
    case title = "title"
        case description = "description"
        case urlToImage = "urlToImage"
    }
}
