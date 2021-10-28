//
//  ArticlesPagingBuilder.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs

protocol ArticlesPagingDependency: Dependency {
    //var articles: [Article] { get }
    var articlesPageController: ArticlesPagingViewController { get set }
}

final class ArticlesPagingComponent: Component<ArticlesPagingDependency>, ArticleDetailDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    
//    fileprivate var articles: [Article] {
//        return dependency.articles
//    }
    
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
        //viewController.articles = component.articles
        
        let articlesDetailsBuilders = articles.map {
            ArticleDetailBuilder(dependency: component, article: $0)
        }
        let interactor = ArticlesPagingInteractor(presenter: viewController)
        interactor.listener = listener
        return ArticlesPagingRouter(interactor: interactor, viewController: viewController, articleDetailsBuilders: articlesDetailsBuilders)
    }
}
