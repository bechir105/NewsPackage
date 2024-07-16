//
//  File.swift
//  
//
//  Created by Bechir Kefi on 16/7/2024.
//

import Foundation

public class NewsManager {
    private let apiKey: String

    public init(apiKey: String) {
        self.apiKey = apiKey
    }

    public func fetchTopHeadlines(completion: @escaping ([Article]?) -> Void) {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            let articlesResponse = try? JSONDecoder().decode(NewsApiResponse.self, from: data)
            completion(articlesResponse?.articles)
        }
        
        task.resume()
    }
}

public struct Article: Decodable {
    public let title: String
    public let description: String?
    public let url: URL
}

struct NewsApiResponse: Decodable {
    let articles: [Article]
}
