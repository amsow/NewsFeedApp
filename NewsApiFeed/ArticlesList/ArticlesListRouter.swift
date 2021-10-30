//
//  ArticlesListRouter.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs

protocol ArticlesListInteractable: Interactable, ArticleDetailListener {
    var router: ArticlesListRouting? { get set }
    var listener: ArticlesListListener? { get set }
}

protocol ArticlesListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func pushViewController(_ viewControllable: ViewControllable, animated: Bool)
}

final class ArticlesListRouter: ViewableRouter<ArticlesListInteractable, ArticlesListViewControllable>, ArticlesListRouting {

    private let articleDetailBuilder: ArticleDetailBuildable
    
    private var currentArticleDetailRouting: ViewableRouting?
    
     init(interactor: ArticlesListInteractable, viewController: ArticlesListViewControllable,
          articleDetailBuilder: ArticleDetailBuildable) {
        self.articleDetailBuilder = articleDetailBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: - ArticlesListRouting
    func routeToArticleDetail(article: Article) {
        detachCurrentChild()
        let router = articleDetailBuilder.build(withListener: interactor, article: article)
        currentArticleDetailRouting = router
        attachChild(router)
        viewController.pushViewController(router.viewControllable, animated: true)
    }
    
    private func detachCurrentChild() {
        if let child = currentArticleDetailRouting {
            detachChild(child)
            currentArticleDetailRouting = nil
        }
    }
}
