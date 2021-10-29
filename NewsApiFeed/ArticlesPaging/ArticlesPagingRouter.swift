//
//  ArticlesPagingRouter.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

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
    
    init(interactor: ArticlesPagingInteractable,
                  viewController: ArticlesPagingViewControllable,
                  articleDetailsBuilder: ArticleDetailBuildable) {
        self.articleDetailsBuilder = articleDetailsBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
       // attachArticlesDetails()
    }
    
    
    // MARK: - Routing
    func attachArticlesDetails(articles: [Article]) {
        let routers = articles.map { articleDetailsBuilder.build(withListener: interactor, article: $0) }
        routers.forEach(attachChild)
        viewController.setViewControllers(routers.map { $0.viewControllable })
    }
}
