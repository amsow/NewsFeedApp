//
//  ArticlesListBuilder.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs

protocol ArticlesListDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ArticlesListComponent: Component<ArticlesListDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ArticlesListBuildable: Buildable {
    func build(withListener listener: ArticlesListListener) -> ArticlesListRouting
}

final class ArticlesListBuilder: Builder<ArticlesListDependency>, ArticlesListBuildable {

    override init(dependency: ArticlesListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ArticlesListListener) -> ArticlesListRouting {
        let component = ArticlesListComponent(dependency: dependency)
        let viewController = ArticlesListViewController()
        let interactor = ArticlesListInteractor(presenter: viewController)
        interactor.listener = listener
        return ArticlesListRouter(interactor: interactor, viewController: viewController)
    }
}
