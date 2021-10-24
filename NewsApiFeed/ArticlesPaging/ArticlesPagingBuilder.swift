//
//  ArticlesPagingBuilder.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs

protocol ArticlesPagingDependency: Dependency {
    
}

final class ArticlesPagingComponent: Component<ArticlesPagingDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ArticlesPagingBuildable: Buildable {
    func build(withListener listener: ArticlesPagingListener) -> ArticlesPagingRouting
}

final class ArticlesPagingBuilder: Builder<ArticlesPagingDependency>, ArticlesPagingBuildable {

    override init(dependency: ArticlesPagingDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ArticlesPagingListener) -> ArticlesPagingRouting {
        let component = ArticlesPagingComponent(dependency: dependency)
        let viewController = ArticlesPagingViewController()
        let interactor = ArticlesPagingInteractor(presenter: viewController)
        interactor.listener = listener
        return ArticlesPagingRouter(interactor: interactor, viewController: viewController)
    }
}
