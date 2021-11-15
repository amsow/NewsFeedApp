//
//  ArticlesPagingRouter.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import Foundation
import RIBs

protocol ArticlesPagingInteractable: Interactable, ArticleDetailListener {
    var router: ArticlesPagingRouting? { get set }
    var listener: ArticlesPagingListener? { get set }
}

protocol ArticlesPagingViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func setViewControllers(_ viewControllers: [ViewControllable])
}

final class ArticlesPagingRouter: ViewableRouter<ArticlesPagingInteractable, ArticlesPagingViewControllable>, ArticlesPagingRouting {
    
    // TODO: Constructor inject child builder protocols to allow building children.
    private let articleDetailsBuilder: ArticleDetailBuildable
    
    private var articleDetailRouters: [ArticleDetailRouting]?
    
    init(interactor: ArticlesPagingInteractable,
         viewController: ArticlesPagingViewControllable,
         articleDetailsBuilder: ArticleDetailBuildable) {
        self.articleDetailsBuilder = articleDetailsBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    
    // MARK: - Routing
    func attachArticlesDetails(articles: [Article]) {
        detachArticleDetailRoutings()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let routers = articles.map { self.articleDetailsBuilder.build(withListener: self.interactor, article: $0) }
            self.articleDetailRouters = routers
            routers.forEach(self.attachChild)
            self.viewController.setViewControllers(routers.map { $0.viewControllable })
        }
    }
    
    private func detachArticleDetailRoutings() {
        if let articleDetailRouters = articleDetailRouters {
            articleDetailRouters.forEach(detachChild)
            viewController.setViewControllers([])
        }
    }
}
