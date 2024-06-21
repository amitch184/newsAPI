//
//  NewsArticle.swift
//  newsApi
//
//  Created by Amit Choudhary on 19/06/24.
//

import Foundation

struct NewsArticle: Decodable {
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}
