//
//  ArticlesListView.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 30/10/2021.
//


import SwiftUI
import RIBs

@available(iOS 13.0.0, *)

struct ArticlesListView: View {
    var items = ["1", "2", "3", "4", "5"]
    @ObservedObject var viewModel: ArticlesListViewModelObject
    
    var body: some View {
        NavigationView {
            List(items, id: \.self) { item in
                
                
                NavigationLink {
                    
                } label: {
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Text for item \(item)")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                        Text("Description for item \(item)")
                    }
                }
                
            }
            .navigationBarTitle(Text("News"))
        }
    }
}

@available(iOS 13.0.0, *)
struct ArticlesListView_Previews: PreviewProvider {
    static var items = ["1", "2", "3", "4", "5", "6", "0", "3"]
    
    static var previews: some View {
        ArticlesListView(items: items, viewModel: ArticlesListViewModelObject())
    }
}
