//
//  ArticlesPagingInteractor.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs
import RxSwift

protocol ArticlesPagingRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func attachArticlesDetails()
}

protocol ArticlesPagingPresentable: Presentable {
    var listener: ArticlesPagingPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol ArticlesPagingListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ArticlesPagingInteractor: PresentableInteractor<ArticlesPagingPresentable>, ArticlesPagingInteractable, ArticlesPagingPresentableListener {

    weak var router: ArticlesPagingRouting?
    weak var listener: ArticlesPagingListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ArticlesPagingPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
