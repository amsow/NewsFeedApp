//
//  RootInteractor.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func attachArticlesPaging(with articles: [Article])
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {
    
//    func articlesLoaded(_ articles: [Article]) {
//        <#code#>
//    }
    
    
    weak var router: RootRouting?
    weak var listener: RootListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RootPresentable) {
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
    
    // MARK: - ArticlesListListener
    func didFinishLoadingArticles(articles: [Article]) {
        router?.attachArticlesPaging(with: articles)
    }
    
    func articlesLoadingOnComplete() {
        print("Paging listener")
    }
}
