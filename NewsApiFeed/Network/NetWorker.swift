//
//  NetWorker.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 25/10/2021.
//

import Foundation

enum NetworkingError: Error {
    case noData
}

class NetWorker: Dispatcher {
    
    var baseUrl: NSString  { "https://newsapi.org/v2/" }
    
    var session: URLSession
    
    typealias CompletionHandler<T> = (Result<T, Error>) -> Void
    
    typealias URLSessionDataTaskResult = (data: Data?, response: URLResponse?, error: Error?)
    
    required init(session: URLSession = .shared) {
        self.session = session
    }
    
    func execute<T>(request: Request, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        session.dataTask(with: prepareURLRequest(for: request)) { (data, response, error) in
            self.dataTaskCompletionHandler(result: (data, response, error), completion: completion)
        }
        .resume()
    }
    
    private func dataTaskCompletionHandler<T: Decodable>(result: URLSessionDataTaskResult,
                                                         completion: @escaping CompletionHandler<T>) {
        
        if let error = result.error {
            completion(.failure(error))
            return
        }
        
        if let _ = result.response as? HTTPURLResponse {
            guard let data = result.data else {
                completion(.failure(NetworkingError.noData))
                return
            }
            completion(decode(T.self, data: data))
        }
    }
    
    private func prepareURLRequest(for request: Request) -> URLRequest {
        let fullURLString = baseUrl.appendingPathComponent(request.path)
        guard let url = URL(string: fullURLString) else { fatalError("The URL is not valid") }
        var urlRequest = URLRequest(url: url)
        
        if let params = request.params {
            switch params {
                case .body(let bodyParams):
                    urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParams, options: .init(rawValue: 0))
                case .url(let urlParams):
                    var components = URLComponents(string: fullURLString)!
                    components.queryItems = urlParams.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
                    urlRequest.url = components.url
            }
        }
        if let headers = request.headers {
            headers.forEach { urlRequest.addValue($0.value , forHTTPHeaderField: $0.key) }
        }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpMethod = request.method.rawValue
        
        return urlRequest
    }
}

fileprivate func decode<T: Decodable>(_ type: T.Type = T.self,
                                      data: Data,
                                      decoder: JSONDecoder = .init()) -> Result<T, Error> {
    do {
        let object = try decoder.decode(type, from: data)
        return .success(object)
    } catch let error {
        return .failure(error)
    }
}

