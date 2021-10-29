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
    //var article: Article { get }
}

final class ArticleDetailComponent: Component<ArticleDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    
    //let article: Article

//    init(dependency: ArticleDetailDependency, article: Article) {
//        self.article = article
//        super.init(dependency: dependency)
//    }
}

// MARK: - Builder

protocol ArticleDetailBuildable: Buildable {
    func build(withListener listener: ArticleDetailListener, article: Article) -> ArticleDetailRouting
}

final class ArticleDetailBuilder: Builder<ArticleDetailDependency>, ArticleDetailBuildable {

//    let article: Article
//
//    init(dependency: ArticleDetailDependency, article: Article) {
//        self.article = article
//        super.init(dependency: dependency)
//    }

    func build(withListener listener: ArticleDetailListener, article: Article) -> ArticleDetailRouting {
        let _ = ArticleDetailComponent(dependency: dependency)
        let viewController = ArticleDetailViewController(article: article)
        let interactor = ArticleDetailInteractor(presenter: viewController)
        interactor.listener = listener
        return ArticleDetailRouter(interactor: interactor, viewController: viewController)
    }
}
