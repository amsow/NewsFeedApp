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

protocol ListPresentable: Presentable {
    var listener: ArticlesListPresentableListener? { get set }
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol ArticlesListPresentable: ListPresentable {
    //var listener: ArticlesListPresentableListener? { get set }
    //var viewModel: ArticlesListViewModel { get set }
    func showError(message: String)
    func reloadTableView()
}

/// Use this protocol while dealing with SwiftUI instead the `ArticlesListPresentable`
@available(iOS 13, *)
protocol ArticlesListPresenting: ListPresentable {
    var listener: ArticlesListPresentableListener? { get set }
    var viewModelObject: ArticlesListViewModelObject { get set }
}

protocol ListViewModeling {
    associatedtype ViewModel: ListViewModel
    var viewModel: ViewModel { get set }
}

protocol ArticlesListListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didFinishLoadingArticles(articles: [Article])
}

final class ArticlesListInteractor: PresentableInteractor<ListPresentable>, ArticlesListInteractable {
    
    weak var router: ArticlesListRouting?
    weak var listener: ArticlesListListener?
    
    private let articlesFetcher: ArticleFetcher
    
    lazy var viewModel = ArticlesListViewModel()
    
    @available(iOS 13.0, *)
    private lazy var getNewsRequestCancellable: AnyCancellable? = nil
    
    @available(iOS 13.0, *)
    lazy var viewModelObject = ArticlesListViewModelObject()
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: ListPresentable,
         articlesFetcher: ArticleFetcher) {
        self.articlesFetcher = articlesFetcher
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        if #available(iOS 13, *) {
          //  presenter
           // presenter.configure(viewModel: viewModelObject)
        } else {
          //  presenter.configure(viewModel: viewModel)
        }
        loadTopHeadlinesArticles()
    }
    
    override func willResignActive() {
        super.willResignActive()
        if #available(iOS 13.0, *) {
            getNewsRequestCancellable = nil
        }
    }
    
    private func loadTopHeadlinesArticles() {
        if #available(iOS 13, *) {
           getNewsRequestCancellable = articlesFetcher.fetchArticles()
                .sink(receiveCompletion: { print("Completion ==> \($0)") },
                      receiveValue: { [weak self] articles in
                    self?.setArticles(with: articles)
                    //self?.setArticles(with: articles)
                    //self?.presenter.reloadTableView()
                    //self?.listener?.didFinishLoadingArticles(articles: articles)
                })
        } else { // For older version than iOS 13
            if self.viewModel.items.isEmpty { presenter.showActivityIndicator() }
            articlesFetcher.fetchArticles { [weak self] result in
                self?.presenter.hideActivityIndicator()
                switch result {
                    case .success(let articles):
                        self?.setArticles(with: articles)
                        DispatchQueue.main.async {
                            self?.listener?.didFinishLoadingArticles(articles: articles)
                        }
                    //    self?.presenter.reloadTableView()
                    case .failure(let error): break
                    //    self?.presenter.showError(message: error.localizedDescription)
                }
            }
        }
    }
    
    private func setArticles(with items: [Article]) {
        if #available(iOS 13, *) {
            viewModelObject.items = items
        } else {
        self.viewModel.items = items
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

