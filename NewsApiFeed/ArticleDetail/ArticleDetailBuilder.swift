//
//  ArticleDetailBuilder.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 28/10/2021.
//

import RIBs

protocol ArticleDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ArticleDetailComponent: Component<ArticleDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ArticleDetailBuildable: Buildable {
    func build(withListener listener: ArticleDetailListener) -> ArticleDetailRouting
}

final class ArticleDetailBuilder: Builder<ArticleDetailDependency>, ArticleDetailBuildable {

    override init(dependency: ArticleDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ArticleDetailListener) -> ArticleDetailRouting {
        let component = ArticleDetailComponent(dependency: dependency)
        let viewController = ArticleDetailViewController()
        let interactor = ArticleDetailInteractor(presenter: viewController)
        interactor.listener = listener
        return ArticleDetailRouter(interactor: interactor, viewController: viewController)
    }
}
