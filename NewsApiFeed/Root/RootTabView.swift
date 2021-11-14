//
//  RootTabView.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 08/11/2021.
//

import SwiftUI

@available(iOS 13, *)
struct RootTabView<List: View, Page: View>: HostableView {
    
    let articlesListView: List
    let articlesPageView: Page
    
    init(@ViewBuilder list: () -> List, @ViewBuilder page: () -> Page) {
        articlesListView = list()
        articlesPageView = page()
    }
    
    var body: some View {
        TabView {
            articlesListView
                .tabItem { Text("TableView") }
            
            articlesPageView
                .tabItem { Text("PageView") }
        }
    }
}

@available(iOS 13, *)
struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {

        RootTabView {
            ArticlesListView(viewModel: ArticlesListViewModelObject())
        } page: {
            ArticleDetailView(article: Article.fake)
        }
    }
}
