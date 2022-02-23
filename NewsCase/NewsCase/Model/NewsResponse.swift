//
//  NewsResponse.swift
//  NewsCase
//
//  Created by burak ozen on 20.02.2022.
//

import Foundation

// MARK: - NewsResponse
struct NewsResponse: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}
