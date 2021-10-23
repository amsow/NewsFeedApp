//
//  ArticlesListRouter.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs

protocol ArticlesListInteractable: Interactable {
    var router: ArticlesListRouting? { get set }
    var listener: ArticlesListListener? { get set }
}

protocol ArticlesListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ArticlesListRouter: ViewableRouter<ArticlesListInteractable, ArticlesListViewControllable>, ArticlesListRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ArticlesListInteractable, viewController: ArticlesListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
