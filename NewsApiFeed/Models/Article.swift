//
//  Article.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 26/10/2021.
//

import Foundation

struct Article: Identifiable {
    let id = UUID()
    let title: String?
    let description: String?
    let url: URL?
    let imageUrl: URL?
    let publishedAt: String?
    let source: Source?
    
    struct Source: Decodable {
        let id: String?
        let name: String?
    }
}

extension Article: Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case url
        case imageUrl = "urlToImage"
        case publishedAt
        case source
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        url = URL(string: try container.decodeIfPresent(String.self, forKey: .url) ?? "")
        imageUrl = URL(string: try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? "")
        publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt)
        source = try container.decodeIfPresent(Source.self, forKey: .source)
    }
}

extension Article {
    static let empty = Self(title: nil, description: nil, url: nil, imageUrl: nil, publishedAt: nil, source: nil)
    static let fake = Self(title: "Qualcomm Stock Rises on Strong Earnings - Barron\'s",
                              description: "The provider of mobile phone chips said revenue was up 43% from a year ago, easily beating Wall Street estimates.\nThe provider of mobile phone chips said revenue was up 43% from a year ago, easily beating Wall Street estimates.",
                              url: URL(string: "https://www.barrons.com/articles/qualcomm-stock-price-earnings-smartphone-demand-51635973720"), imageUrl: URL(string: "https://images.barrons.com/im-428307/social"), publishedAt: nil, source: nil)
}
