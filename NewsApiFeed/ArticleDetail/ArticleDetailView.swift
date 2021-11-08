//
//  ArticleDetailView.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 30/10/2021.
//

import SwiftUI

@available(iOS 13.0.0, *)
struct ArticleDetailView: HostableView {
    
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
    
    static var previews: some View {
        ArticleDetailView(article: Article.fake)
    }
}
