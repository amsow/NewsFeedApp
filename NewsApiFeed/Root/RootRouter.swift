//
//  RootRouter.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs
import Foundation
import UIKit

protocol RootInteractable: Interactable, ArticlesListListener, ArticlesPagingListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func setViewControllers(_ viewControllers: [ViewControllable])
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    // TODO: Constructor inject child builder protocols to allow building children.
    private let articlesListBuilder: ArticlesListBuildable
    private let articlesPagingBuilder: ArticlesPagingBuildable
    
    private var articlesPagingRouter: ArticlesPagingRouting?
    
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         articlesListBuilder: ArticlesListBuildable,
         articlesPagingBuilder: ArticlesPagingBuildable) {
        self.articlesListBuilder = articlesListBuilder
        self.articlesPagingBuilder = articlesPagingBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        attachArticlesList()
        attachArticlesPaging(with: [])
    }
    
    // MARK: - RootRouting
    
    func attachArticlesPaging(with articles: [Article]) {
        print("****** Articles count ==> \(articles.count)")
        let router = articlesPagingBuilder.build(withListener: interactor, articles: articles)
        articlesPagingRouter = router
        attachChild(router)
    }
    
    // MARK: - Private helpers
    private func attachArticlesList() {
        let articlesListRouter = articlesListBuilder.build(withListener: interactor)
        attachChild(articlesListRouter)
    }
}
