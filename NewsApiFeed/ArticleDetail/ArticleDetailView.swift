//
//  ArticleDetailView.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 30/10/2021.
//

import SwiftUI

@available(iOS 13.0.0, *)
struct ArticleDetailView: View {
    
    let article: Article
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            if #available(iOS 15, *) {
                AsyncImage(url: article.imageUrl) { image in
                    image
                        .resizable()
                } placeholder: {
                    Image("news_placeholder")
                        .resizable()
                }
                .scaledToFill()
                .frame(height: 300, alignment: .center)
            } else {
                Image(article.imageUrl!.absoluteString).resizable() //"news_placeholder"
                    .frame(height: 300, alignment: .center)
                    .aspectRatio(contentMode: .fit)
            }
        
            VStack(alignment: .leading, spacing: 5) {
                Text(article.title!)
                    .font(.title)
                    .fontWeight(.medium)
                    
                Text(article.description!)
                    .font(.system(size: 22))
                    
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 8)
            Button("Open in Safari") {
                
            }
            Spacer()
        }
        .navigationBarTitle(Text(article.source?.name ?? ""))
    }
        
}

@available(iOS 13.0.0, *)
struct ArticleDetailView_Previews: PreviewProvider {
    static var article = Article(title: "Qualcomm Stock Rises on Strong Earnings - Barron\'s",
                                 description: "The provider of mobile phone chips said revenue was up 43% from a year ago, easily beating Wall Street estimates.\nThe provider of mobile phone chips said revenue was up 43% from a year ago, easily beating Wall Street estimates.",
                                 url: URL(string: "https://www.barrons.com/articles/qualcomm-stock-price-earnings-smartphone-demand-51635973720"), imageUrl: URL(string: "https://images.barrons.com/im-428307/social"), publishedAt: nil, source: nil)
    static var previews: some View {
        ArticleDetailView(article: article)
    }
}
