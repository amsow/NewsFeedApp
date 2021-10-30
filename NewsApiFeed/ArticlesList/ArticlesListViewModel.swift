//
//  ArticlesListViewModel.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 29/10/2021.
//

import Foundation

protocol ListViewModel: AnyObject {
    associatedtype Item
    var items: [Item] { get set }
}

extension ListViewModel {
    func numberOfItems() -> Int {
        return items.count
    }
    
    func item(at index: Int) -> Item? {
        guard numberOfItems() > index else {
            return nil
        }
        return items[index]
    }
}

final class ArticlesListViewModel: ListViewModel {
    
    var items = [Article]()
    
     init() { }
}


@available(iOS 13.0, *)
final class ArticlesListViewModelObject: ObservableObject, ListViewModel {
    
    @Published var items = [Article]()
    
     init() { }
}


