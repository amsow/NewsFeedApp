//
//  ArticleFetcher.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 24/10/2021.
//

import Foundation
import Combine

protocol ArticleFetcher {
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void)
    @available(iOS 13.0, *)
    func fetchArticles() -> AnyPublisher<[Article], Error>
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
    
    @available(iOS 13.0, *)
    func fetchArticles() -> AnyPublisher<[Article], Error> {
        return webservice.execute(request: BusinessTopHeadlinesRequest())
            .map(GetArticlesResponse.init)
            .map(\.articles)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct GetArticlesResponse: Decodable {
    let articles: [Article]
}
