//
//  RootBuilder.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs
import UIKit

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {
     
    let rootViewController: RootViewController
    let articleListViewController: ArticlesListViewController
    var articlesPageController: ArticlesPagingViewController
    
    let articlesFetcher: ArticleFetcher
    
     init(dependency: RootDependency,
          rootViewController: RootViewController,
          articlesListController: ArticlesListViewController,
          articlesPageController: ArticlesPagingViewController,
          articlesFetcher: ArticleFetcher) {
        self.rootViewController = rootViewController
        self.articleListViewController = articlesListController
        self.articlesPageController = articlesPageController
        self.articlesFetcher = articlesFetcher
        super.init(dependency: dependency)
    }
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let articlesListController = ArticlesListViewController()
        let articlesPageController = ArticlesPagingViewController()
        let tabBarController = RootViewController()
        
        let component = RootComponent(dependency: dependency,
                                      rootViewController: tabBarController,
                                      articlesListController: articlesListController,
                                      articlesPageController: articlesPageController,
                                      articlesFetcher: ArticlesFetcherImpl(webservice: NetWorker()))
        let articlesListNavController = UINavigationController(rootViewController: articlesListController)
        let pagingNavController = UINavigationController(rootViewController: articlesPageController)
        tabBarController.viewControllers = [articlesListNavController, pagingNavController]
        let interactor = RootInteractor(presenter: tabBarController)
        let articlesListBuilder = ArticlesListBuilder(dependency: component)
        let articlesPagingBuilder = ArticlesPagingBuilder(dependency: component)
        return RootRouter(interactor: interactor,
                          viewController: tabBarController,
                          articlesListBuilder: articlesListBuilder,
                          articlesPagingBuilder: articlesPagingBuilder)
    }
}
