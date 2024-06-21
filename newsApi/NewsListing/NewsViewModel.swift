//
//  NewsViewModel.swift
//  newsApi
//
//  Created by Amit Choudhary on 19/06/24.
//

import Foundation

class NewsViewModel {
    var articles: [NewsArticle] = []
    var bookmarkedArticles: [NewsArticle] = []
    var onUpdate: (() -> Void)?
    
    func fetchNews(category: String) {
        NetworkManager.shared.fetchNews(category: category) { [weak self] articles in
            if let articles = articles {
                self?.articles = articles
                self?.onUpdate?()
            }
        }
    }
    
    func bookmarkArticle(at index: Int) {
        let article = articles[index]
        bookmarkedArticles.append(article)
    }
    
    func isBookmarked(article: NewsArticle) -> Bool {
        return bookmarkedArticles.contains(where: { $0.title == article.title })
    }
    
    func getArticle(at index: Int) -> NewsArticle {
        return articles[index]
    }
    
    func numberOfArticles() -> Int {
        return articles.count
    }
}

