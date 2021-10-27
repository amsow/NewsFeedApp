//
//  Dispatcher.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 24/10/2021.
//

import Foundation

struct Environment {
    static let NewsAPIKey = "e8c61255af7e42a5b8b77db5bf2e6d3b"
}

protocol Dispatcher: AnyObject {
    
    var baseUrl: NSString { get }
    var session: URLSession { get set }
    
    init(session: URLSession)
    
    func execute<T: Decodable>(request: Request, completion: @escaping (Result<T, Error>) -> Void)
}


protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var params: RequestParams? { get }
    var headers: [String: String]? { get }
}

enum HTTPMethod: String {
    
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
    
}

enum RequestParams {
    case body(Any)
    case url([String:Any])
}


struct BusinessTopHeadlinesRequest: Request {
    
    var path: String { return "top-headlines" }
    
    var method: HTTPMethod { return .get }
    
    var params: RequestParams? {
        return .url(["country": "us", "category": "business", "apiKey": Environment.NewsAPIKey])
    }
    
    let headers: [String : String]? = nil
    
}
