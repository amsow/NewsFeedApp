//
//  ArticlesListBuilder.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs
import UIKit

protocol ArticlesListDependency: Dependency {
    var articleListViewController: ArticlesListViewController { get }
    var articlesFetcher: ArticleFetcher { get }
}

final class ArticlesListComponent: Component<ArticlesListDependency>, ArticleDetailDependency {
    
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
        let viewController = dependency.articleListViewController
        let interactor = ArticlesListInteractor(presenter: viewController,
                                                viewModel: ArticlesListViewModel(),
                                                articlesFetcher: dependency.articlesFetcher)
        interactor.listener = listener
        viewController.viewModel = interactor.viewModel
        return ArticlesListRouter(interactor: interactor, viewController: viewController)
    }
}
