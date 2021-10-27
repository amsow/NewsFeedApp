//
//  ArticleFetcher.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 24/10/2021.
//

import Foundation

protocol ArticleFetcher {
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void)
}

final class ArticlesFetcherImpl: ArticleFetcher {
    
    let webservice: Dispatcher
    
    init(webservice: Dispatcher) {
        self.webservice = webservice
    }
    
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        webservice.execute(request: BusinessTopHeadlinesRequest()) { (result: Result<GetArticlesResponse, Error>) in
            do {
                let returnedArticles = try result.get().articles
                completion(.success(returnedArticles))
            } catch {
                print("Error ====> \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}

struct GetArticlesResponse: Decodable {
    let articles: [Article]
}
