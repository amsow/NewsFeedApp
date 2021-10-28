//
//  ArticlesListInteractor.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import Foundation
import RIBs
import RxSwift


protocol ArticlesListRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ListPresentable {
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol ArticlesListPresentable: Presentable, ListPresentable {
    var listener: ArticlesListPresentableListener? { get set }
    var viewModel: ArticlesListViewModel! { get set }
    func showError(message: String)
    func reloadTableView()
}

protocol ArticlesListListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didFinishLoadingArticles()
}

final class ArticlesListInteractor: PresentableInteractor<ArticlesListPresentable>, ArticlesListInteractable {

    weak var router: ArticlesListRouting?
    weak var listener: ArticlesListListener?
    
    private let articlesFetcher: ArticleFetcher
    
    let viewModel: ArticlesListViewModel

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: ArticlesListPresentable,
         viewModel: ArticlesListViewModel,
         articlesFetcher: ArticleFetcher) {
        self.viewModel = viewModel
        self.articlesFetcher = articlesFetcher
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        loadTopHeadlinesArticles()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    private func loadTopHeadlinesArticles() {
        if self.viewModel.items.isEmpty { presenter.showActivityIndicator() }
        articlesFetcher.fetchArticles { [weak self] result in
            self?.presenter.hideActivityIndicator()
            switch result {
                case .success(let articles):
                    self?.viewModel.items = articles
                    self?.presenter.reloadTableView()
                case .failure(let error):
                    self?.presenter.showError(message: error.localizedDescription)
            }
        }
    }
}

// MARK: - ArticlesListPresentableListener
extension ArticlesListInteractor: ArticlesListPresentableListener {
    func didRefresh() {
        loadTopHeadlinesArticles()
    }
    
    func didSelectArticle(at indexPath: IndexPath) {
        
    }
}


final class ArticlesListViewModel: ListViewModel {
    
    var items = [Article]()
    
     init() { }
}

protocol ListViewModel: class {
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