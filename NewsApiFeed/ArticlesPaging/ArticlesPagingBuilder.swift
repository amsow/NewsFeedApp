//
//  ArticlesPagingBuilder.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs

protocol ArticlesPagingDependency: Dependency {
    var articlesPageController: ArticlesPagingViewController { get set }
}

final class ArticlesPagingComponent: Component<ArticlesPagingDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    
    fileprivate var articlesPageController: ArticlesPagingViewController {
        return dependency.articlesPageController
    }
}

// MARK: - Builder

protocol ArticlesPagingBuildable: Buildable {
    func build(withListener listener: ArticlesPagingListener, articles: [Article]) -> ArticlesPagingRouting
}

final class ArticlesPagingBuilder: Builder<ArticlesPagingDependency>, ArticlesPagingBuildable {

    override init(dependency: ArticlesPagingDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ArticlesPagingListener, articles: [Article]) -> ArticlesPagingRouting {
        let component = ArticlesPagingComponent(dependency: dependency)
        let viewController = component.articlesPageController
        viewController.articles = articles
        let interactor = ArticlesPagingInteractor(presenter: viewController)
        interactor.listener = listener
        return ArticlesPagingRouter(interactor: interactor, viewController: viewController)
    }
}
