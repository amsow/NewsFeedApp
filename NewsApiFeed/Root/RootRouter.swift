//
//  RootRouter.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs

protocol RootInteractable: Interactable, ArticlesListListener, ArticlesPagingListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    private let articlesListBuilder: ArticlesListBuildable
    private let articlesPagingBuilder: ArticlesPagingBuildable
    
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
        attachArticlesPaging()
    }
    
    // MARK: - RootRouting
    func routeToArticlesList() {
       // let builder = ArticlesListBuilder(dependency: )
    }
    
    func routeToArticlesPaging() {
        
    }
    
    private func attachArticlesList() {
        let articlesListRouter = articlesListBuilder.build(withListener: interactor)
        attachChild(articlesListRouter)
    }
    
    private func attachArticlesPaging() {
        let articlesPagingRouter = articlesPagingBuilder.build(withListener: interactor)
        attachChild(articlesPagingRouter)
    }
}
