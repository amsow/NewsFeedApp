//
//  ArticleDetailInteractor.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 28/10/2021.
//

import RIBs
import RxSwift

protocol ArticleDetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ArticleDetailPresentable: Presentable {
    var listener: ArticleDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol ArticleDetailListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ArticleDetailInteractor: PresentableInteractor<ArticleDetailPresentable>, ArticleDetailInteractable, ArticleDetailPresentableListener {

    weak var router: ArticleDetailRouting?
    weak var listener: ArticleDetailListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ArticleDetailPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
