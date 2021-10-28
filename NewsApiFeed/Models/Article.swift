//
//  Article.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 26/10/2021.
//

import Foundation

struct Article {
    let title: String?
    let description: String?
    let url: URL?
    let imageUrl: URL?
    let publishedAt: String?
}

extension Article: Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case url
        case imageUrl = "urlToImage"
        case publishedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        url = URL(string: try container.decodeIfPresent(String.self, forKey: .url) ?? "")
        imageUrl = URL(string: try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? "")
        publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt)
    }
}

extension Article {
    static let empty = Self(title: nil, description: nil, url: nil, imageUrl: nil, publishedAt: nil)
}
