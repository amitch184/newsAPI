//
//  NetworkManager.swift
//  newsApi
//
//  Created by Amit Choudhary on 19/06/24.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = "ad3f32c5693f47fdad29c05ea5e3fe5a"
    private let baseURL = "https://newsapi.org/v2"
    
    func fetchNews(category: String, completion: @escaping ([NewsArticle]?) -> Void) {
        let url = "\(baseURL)/top-headlines?country=us&category=\(category)&apiKey=\(apiKey)"
        
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let articles = json["articles"].arrayValue.map { articleJSON -> NewsArticle in
                    return NewsArticle(
                        title: articleJSON["title"].stringValue,
                        description: articleJSON["description"].stringValue,
                        url: articleJSON["url"].stringValue,
                        urlToImage: articleJSON["urlToImage"].stringValue,
                        publishedAt: articleJSON["publishedAt"].stringValue,
                        content: articleJSON["content"].stringValue
                    )
                }
                completion(articles)
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
}
