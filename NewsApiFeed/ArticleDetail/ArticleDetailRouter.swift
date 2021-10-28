//
//  ArticleDetailRouter.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 28/10/2021.
//

import RIBs
import Foundation

protocol ArticleDetailInteractable: Interactable {
    var router: ArticleDetailRouting? { get set }
    var listener: ArticleDetailListener? { get set }
}

protocol ArticleDetailViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func showArticleInBrowser(with url: URL)
}

final class ArticleDetailRouter: ViewableRouter<ArticleDetailInteractable, ArticleDetailViewControllable>, ArticleDetailRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ArticleDetailInteractable, viewController: ArticleDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: - ArticleDetailRouting
    func routeToSafariBrowser(url: URL) {
        viewController.showArticleInBrowser(with: url)
    }
}
