//
//  ArticlesPagingRouter.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs

protocol ArticlesPagingInteractable: Interactable {
    var router: ArticlesPagingRouting? { get set }
    var listener: ArticlesPagingListener? { get set }
}

protocol ArticlesPagingViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ArticlesPagingRouter: ViewableRouter<ArticlesPagingInteractable, ArticlesPagingViewControllable>, ArticlesPagingRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ArticlesPagingInteractable, viewController: ArticlesPagingViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
