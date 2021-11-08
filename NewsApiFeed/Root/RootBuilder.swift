//
//  RootBuilder.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs
//import UIKit

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {
    
    let rootViewController: RootViewController
    let articleListViewController: ArticlesListViewControllable
    var articlesPageController: ArticlesPagingViewController
    
    let articlesFetcher: ArticleFetcher
    
    let viewModel: ViewModel
    
    init(dependency: RootDependency,
         rootViewController: RootViewController,
         articlesListController: ArticlesListViewControllable,
         articlesPageController: ArticlesPagingViewController,
         articlesFetcher: ArticleFetcher,
         viewModel: ViewModel) {
        self.rootViewController = rootViewController
        self.articleListViewController = articlesListController
        self.articlesPageController = articlesPageController
        self.articlesFetcher = articlesFetcher
        self.viewModel = viewModel
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
        
        let component = makeRootComponent()
        
        let interactor = RootInteractor(presenter: component.rootViewController)
        let articlesListBuilder = ArticlesListBuilder(dependency: component)
        let articlesPagingBuilder = ArticlesPagingBuilder(dependency: component)
        return RootRouter(interactor: interactor,
                          viewController: component.rootViewController,
                          articlesListBuilder: articlesListBuilder,
                          articlesPagingBuilder: articlesPagingBuilder)
    }
    
    // MARK: - Private
    private func makeRootComponent() -> RootComponent {
        let viewModel: ViewModel = {
            if #available(iOS 13, *) {
                return ArticlesListViewModelObject()
            }
            return ArticlesListViewModel()
        }()
        let rootController = RootViewController()
        //RootViewController.make(withListViewModel: viewModel)
        let articlesListController = ArticlesListViewController.make(with: viewModel)
        let articlesPageController = ArticlesPagingViewController()
        
        let childViewControllers: [ViewControllable] = [articlesListController, articlesPageController]
        
        rootController.setViewControllers(childViewControllers)
        
        let component = RootComponent(dependency: dependency,
                                      rootViewController: rootController,
                                      articlesListController: articlesListController,
                                      articlesPageController: articlesPageController,
                                      articlesFetcher: ArticlesFetcherImpl(webservice: NetWorker()),
                                      viewModel: viewModel)
        return component
    }
}
