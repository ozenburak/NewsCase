//
//  Article.swift
//  NewsCase
//
//  Created by burak ozen on 20.02.2022.
//

import Foundation

// MARK: - Article
struct Article: Codable {
    var source: Source
    var author: String?
    var title, articleDescription: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var content: String

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}


