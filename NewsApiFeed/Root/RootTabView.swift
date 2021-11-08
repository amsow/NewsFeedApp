//
//  RootTabView.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 08/11/2021.
//

import SwiftUI

@available(iOS 13, *)
struct RootTabView<List: View, Detail: View>: View {
    
    let articlesListView: List
    let articleDetailView: Detail
    
    init(@ViewBuilder list: () -> List, @ViewBuilder detail: () -> Detail) {
        articlesListView = list()
        articleDetailView = detail()
    }
    
    var body: some View {
        TabView {
            articlesListView
                .tabItem {
                   Text("TableView")
                }
            articleDetailView
                .tabItem {
                    Text("Article Detail")
                }
        }
    }
}

@available(iOS 13, *)
struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {

        RootTabView {
            ArticlesListView(viewModel: ArticlesListViewModelObject())
        } detail: {
            ArticleDetailView(article: Article.fake)
        }
    }
}
