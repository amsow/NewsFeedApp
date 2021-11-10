//
//  ArticlesListView.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 30/10/2021.
//


import SwiftUI
import RIBs

@available(iOS 13.0.0, *)

struct ArticlesListView: HostableView {
    
    @ObservedObject var viewModel: ArticlesListViewModelObject
    
    var body: some View {
        NavigationView {
            List(viewModel.items, id: \.id) { article in
                NavigationLink(destination: ArticleDetailView(article: article)) {
                    ArticleItemView(title: article.title ?? "", description: article.description ?? "")
                        .frame(height: 80, alignment: .leading)
                        .buttonStyle(PlainButtonStyle())
                }
            }
            .navigationBarTitle(Text("News"))
        }
        .background(Color.red)
    }
        
}

@available(iOS 13.0.0, *)
struct ArticleItemView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .font(.system(size: 20))
                .fontWeight(.medium)
                .lineLimit(1)
            Text(description)
                .font(.system(size: 16))
                .lineLimit(1)
        }
        .frame(height: 80, alignment: .leading)
    }
}

@available(iOS 13.0.0, *)
struct ArticlesListView_Previews: PreviewProvider {
    
    static var viewModel = ArticlesListViewModelObject()
    
    static var previews: some View {
        ArticlesListView(viewModel: viewModel)
    }
}
