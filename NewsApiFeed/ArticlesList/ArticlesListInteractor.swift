//
//  ArticlesListInteractor.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import Foundation
import Combine
import RIBs
import RxSwift



protocol ArticlesListRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToArticleDetail(article: Article)
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
    func didFinishLoadingArticles(articles: [Article])
}

final class ArticlesListInteractor: PresentableInteractor<ArticlesListPresentable>, ArticlesListInteractable {
    
    weak var router: ArticlesListRouting?
    weak var listener: ArticlesListListener?
    
    private let articlesFetcher: ArticleFetcher
    
    let viewModel: ArticlesListViewModel
    
    @available(iOS 13.0, *)
    private lazy var getNewsRequestCancellable: AnyCancellable? = nil
    
    @available(iOS 13.0, *)
    private lazy var viewModelObject = ArticlesListViewModelObject()
    
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
        if #available(iOS 13.0, *) {
            getNewsRequestCancellable = nil
        }
    }
    
    private func loadTopHeadlinesArticles() {
        if self.viewModel.items.isEmpty { presenter.showActivityIndicator() }
        if #available(iOS 13, *) {
           getNewsRequestCancellable = articlesFetcher.fetchArticles()
                .sink(receiveCompletion: { _ in },
                      receiveValue: { [weak self] articles in
                    self?.viewModelObject.items = articles
                })
        } else { // For older version than iOS 13
            articlesFetcher.fetchArticles { [weak self] result in
                self?.presenter.hideActivityIndicator()
                switch result {
                    case .success(let articles):
                        self?.viewModel.items = articles
                        DispatchQueue.main.async {
                            self?.listener?.didFinishLoadingArticles(articles: articles)
                        }
                        self?.presenter.reloadTableView()
                    case .failure(let error):
                        self?.presenter.showError(message: error.localizedDescription)
                }
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
        guard let article = viewModel.item(at: indexPath.row) else { return }
        router?.routeToArticleDetail(article: article)
    }
}
