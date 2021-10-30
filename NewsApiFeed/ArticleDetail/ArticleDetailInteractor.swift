//
//  ArticleDetailInteractor.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 28/10/2021.
//

import RIBs
import Foundation

protocol ArticleDetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToSafariBrowser(url: URL)
}

protocol ArticleDetailPresentable: Presentable {
    var listener: ArticleDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func setViews(with article: Article)
}

protocol ArticleDetailListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ArticleDetailInteractor: PresentableInteractor<ArticleDetailPresentable>, ArticleDetailInteractable, ArticleDetailPresentableListener {
   
    weak var router: ArticleDetailRouting?
    weak var listener: ArticleDetailListener?
    
    private let article: Article

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: ArticleDetailPresentable, article: Article) {
        self.article = article
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        presenter.setViews(with: article)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - ArticleDetailPresentableListener
    func didOpenArticleInSafariBrowser() {
        if let url = article.url {
            router?.routeToSafariBrowser(url: url)
        }
    }
}
